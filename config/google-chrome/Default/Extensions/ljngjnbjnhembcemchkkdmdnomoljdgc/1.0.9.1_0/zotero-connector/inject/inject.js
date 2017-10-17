/*
    ***** BEGIN LICENSE BLOCK *****
    
    Copyright © 2009 Center for History and New Media
                     George Mason University, Fairfax, Virginia, USA
                     http://zotero.org
    
    This file is part of Zotero.
    
    Zotero is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    Zotero is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with Zotero.  If not, see <http://www.gnu.org/licenses/>.
    
    ***** END LICENSE BLOCK *****
*/

/**
 * Only register progress window code in top window
 */
var isTopWindow = false;
if(window.top) {
	try {
		isTopWindow = window.top == window;
	} catch(e) {};
}


/**
 * @namespace
 */
var instanceID = (new Date()).getTime();
Zotero.Inject = new function() {
	var _translate;
	this.translators = [];
	
	function determineAttachmentIcon(attachment) {
		if(attachment.linkMode === "linked_url") {
			return Zotero.ItemTypes.getImageSrc("attachment-web-link");
		}
		return Zotero.ItemTypes.getImageSrc(attachment.mimeType === "application/pdf"
							? "attachment-pdf" : "attachment-snapshot");
	}
	
	/**
	 * Translates this page. First, retrieves schema and preferences from global script, then
	 * passes them off to _haveSchemaAndPrefs
	 */
	this.translate = function(translator) {
		// this relays an item from this tab to the top level of the window
		_translate.setTranslator(translator);
		_translate.translate();
	};
	
	/**
	 * Initializes the translate machinery and determines whether this page can be translated
	 */
	this.detect = function(force) {	
		// Check if document is a PDF file
		try {
			if (document.body.childElementCount === 1) {
				var embed = document.body.firstElementChild;
				if (embed.tagName === "EMBED" && embed.getAttribute("type") === "application/pdf") {
					Zotero.Connector_Browser.onTranslators("pdfurl", instanceID);
					return;
				}
			}
		} catch (e) {
			Zotero.logError(e);
		}
		
		// wrap this in try/catch so that errors will reach logError
		try {
			if(this.translators.length) {
				if(force) {
					this.translators = [];
				} else {
					return;
				}
			}
			if(document.location == "about:blank") return;

			if(!_translate) {
				var me = this;
				_translate = new Zotero.Translate.Web();
				_translate.setDocument(document);
				_translate.setHandler("translators", function(obj, translators) {
					if(translators.length) {
						me.translators = translators;
						for(var i=0; i<translators.length; i++) {
							if(translators[i].properToProxy) {
								delete translators[i].properToProxy;
							}
						}
						Zotero.Connector_Browser.onTranslators(translators, instanceID);
					}
				});
				// _translate.setHandler("select", function(obj, items, callback) {
					// TODO
				// });
				_translate.setHandler("itemSaving", function(obj, item) {
					Zotero.Connector_Browser.onItemMetadataRetrieved(item);
				});
				_translate.setHandler("pageModified", function() {
					Zotero.Connector_Browser.onPageLoad();
					Zotero.Messaging.sendMessage("pageModified", null);
				});
				document.addEventListener("ZoteroItemUpdated", function() {
					Zotero.debug("Inject: ZoteroItemUpdated event received");
					Zotero.Connector_Browser.onPageLoad();
					Zotero.Messaging.sendMessage("pageModified", null);
				}, false);
			}
			_translate.getTranslators();
		} catch(e) {
			Zotero.logError(e);
		}
	};
};

// check whether this is a hidden browser window being used for scraping
var isHiddenIFrame = false;
try {
	isHiddenIFrame = !isTopWindow && window.frameElement && window.frameElement.style.display === "none";
} catch(e) {}

// don't try to scrape on hidden frames
if(!isHiddenIFrame && (window.location.protocol === "http:" || window.location.protocol === "https:")) {
	// add listener for translate message from extension
	Zotero.Messaging.addMessageListener("translate", function(data) {
		if(data[0] !== instanceID) return;
		Zotero.Inject.translate(data[1]);
	});
	// add listener to rerun detection on page modifications
	Zotero.Messaging.addMessageListener("pageModified", function() {
		Zotero.Inject.detect(true);
	});
	// initialize
	Zotero.initInject();
	
	// Send page load event to clear current save icon/data
	if(isTopWindow) Zotero.Connector_Browser.onPageLoad();

	if(document.readyState !== "complete") {
		window.addEventListener("load", function(e) {
				if(e.target !== document) return;
				Zotero.Inject.detect();
			}, false);
	} else {	
		Zotero.Inject.detect();
	}
}