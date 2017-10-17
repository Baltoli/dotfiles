/*
    ***** BEGIN LICENSE BLOCK *****
    
    Copyright © 2009-2012 Center for History and New Media
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

Zotero.Connector_Browser = new function() {
	var _translatorsForTabIDs = {};
	var _instanceIDsForTabs = {};
	var _selectCallbacksForTabIDs = {};
	var _incompatibleVersionMessageShown;
	var _dontprintJobIdForTabId = {};
	
	/**
	 * Called when translators are available for a given page
	 */
	this.onTranslators = function(translators, instanceID, tab) {
		if (translators === "pdfurl") {
			// The document displayed in the tab is a PDF document and the
			// argument "translators" does not actually reference any translators
			showPageAction(tab.id, _dontprintJobIdForTabId[tab.id], "pdfurl");
			return;
		}
		var oldTranslators = _translatorsForTabIDs[tab.id];
		if(oldTranslators && oldTranslators.length
			&& (!translators.length || oldTranslators[0].priority <= translators[0].priority)) return;
		_translatorsForTabIDs[tab.id] = translators;
		_instanceIDsForTabs[tab.id] = instanceID;

		var itemType = translators[0].itemType;
		if (itemType && Dontprint.itemTypeBlacklist.indexOf(itemType) === -1) {
			showPageAction(tab.id, _dontprintJobIdForTabId[tab.id]);
		} else {
			chrome.pageAction.hide(tab.id);
		}
	}
	
	/**
	 * Called to display select items dialog
	 */
	this.onSelect = function(items, callback, tab) {
		window.open(chrome.extension.getURL("itemSelector/itemSelector.html")+"#"+encodeURIComponent(JSON.stringify([tab.id, items])), '',
		'height=325,width=500,location=no,toolbar=no,menubar=no,status=no');
		_selectCallbacksForTabIDs[tab.id] = callback;
	}
	
	/**
	 * Called when a tab is removed or the URL has changed
	 */
	this.onPageLoad = function(tab) {
		if(tab) _clearInfoForTab(tab.id);
	}
	
	/**
	 * Called when Zotero goes online or offline
	 */
	this.onStateChange = function() {
		if(!Zotero.Connector.isOnline) {
			for(var i in _translatorsForTabIDs) {
				if(_translatorsForTabIDs[i] && _translatorsForTabIDs[i].length
						&& _translatorsForTabIDs[i][0].runMode === Zotero.Translator.RUN_MODE_ZOTERO_STANDALONE) {
					try {
						chrome.pageAction.hide(i);
					} catch(e) {}
				}
			}
		}
	}
	
	/**
	 * Called if Zotero version is determined to be incompatible with Standalone
	 */
	this.onIncompatibleStandaloneVersion = function(zoteroVersion, standaloneVersion) {
		// ignore
	}
	
	/**
	 * For Dontprint: Called by the translation system when the metadata of an
	 * article (including the URLs of its attachments) have been retrieved.
	 */
	this.onItemMetadataRetrieved = function(item, tab) {
		Dontprint.zoteroTranslatorDone(_dontprintJobIdForTabId[tab.id], item);
	}

	/**
	 * Removes information about a specific tab
	 */
	function _clearInfoForTab(tabID) {
		delete _translatorsForTabIDs[tabID];
		delete _instanceIDsForTabs[tabID];
		delete _selectCallbacksForTabIDs[tabID];
		chrome.pageAction.hide(tabID);
	}

	Zotero.Messaging.addMessageListener("selectDone", function(data) {
		_selectCallbacksForTabIDs[data[0]](data[1]);
	});

	chrome.tabs.onRemoved.addListener(_clearInfoForTab);

	chrome.tabs.onUpdated.addListener(function(tabID, changeInfo, tab) {
		// Rerun translation if a tab's URL changes
		if(!changeInfo.url) return;
		Zotero.debug("Connector_Browser: URL changed for tab");
		_clearInfoForTab(tabID);
		chrome.tabs.sendRequest(tabID, ["pageModified"], null);
	});

	this.dontprintRegisterJobId = function(job) {
		_dontprintJobIdForTabId[job.tabId] = job.id;
	};

	this.dontprintRunZoteroTranslator = function(job) {
		chrome.pageAction.setPopup({
			tabId: job.tabId,
			popup: "common/progress/popup.html#" + job.tabId + "||" + job.id
		});

		chrome.tabs.sendRequest(
			job.tabId,
			["translate", [_instanceIDsForTabs[job.tabId], _translatorsForTabIDs[job.tabId][0]]],
			null
		);
	};

	this.dontprintJobStarted = function(job) {
		if (typeof job.tabId !== "undefined") {
			showPageAction(job.tabId, job.id);
		}
	}

	this.dontprintJobDone = function(job) {
		if (_dontprintJobIdForTabId[job.tabId] === job.id) {
			delete _dontprintJobIdForTabId[job.tabId];
			if (typeof job.tabId !== "undefined") {
				showPageAction(job.tabId, undefined, job.jobType);
			}
		}
	};


	function showPageAction(tabId, jobId, jobType) {
		if (!jobType) {
			jobType = "page";
		}
		var popupUrl = "common/progress/popup.html#" + tabId + "|" + jobType;
		var iconFile = "common/icons/dontprint";
		var pageActionTitle = "Dontprint this article (send to e-reader)";
		if (jobId !== undefined) {
			popupUrl += "|" + jobId;
			iconFile += "-busy";
			pageActionTitle = "Dontprint in progress (click for details)";
		}

		chrome.pageAction.setPopup({
			tabId: tabId,
			popup: popupUrl
		});
		chrome.pageAction.setIcon({
			tabId: tabId,
			path: {
				"19": iconFile + "-19px.png",
				"38": iconFile + "-38px.png"
			}
		});
		chrome.pageAction.setTitle({
			tabId: tabId,
			title: pageActionTitle
		});
		chrome.pageAction.show(tabId);
	}
}

Zotero.initGlobal();