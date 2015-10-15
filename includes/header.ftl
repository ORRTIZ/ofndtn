<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#assign docLangAttr = locale.toString()?replace("_", "-")>
<#assign langDir = "ltr">
<#if "ar.iw"?contains(docLangAttr?substring(0, 2))>
    <#assign langDir = "rtl">
</#if>
<#if person?has_content>
  <#assign userName = person.firstName?if_exists + " " + person.middleName?if_exists + " " + person.lastName?if_exists>
<#elseif partyGroup?has_content>
  <#assign userName = partyGroup.groupName?if_exists>
<#elseif userLogin?exists>
  <#assign userName = userLogin.userLoginId>
<#else>
  <#assign userName = "">
</#if>
<#if defaultOrganizationPartyGroupName?has_content>
  <#assign orgName = " - " + defaultOrganizationPartyGroupName?if_exists>
<#else>
  <#assign orgName = "">
</#if>
<#if layoutSettings.headerImageLinkUrl?exists>
  <#assign logoLinkURL = "${layoutSettings.headerImageLinkUrl}">
<#else>
  <#assign logoLinkURL = "${layoutSettings.commonHeaderImageLinkUrl}">
</#if>
<#assign organizationLogoLinkURL = "${layoutSettings.organizationLogoLinkUrl?if_exists}">
<#if layoutSettings.headerImageUrl?exists>
    <#assign headerImageUrl = layoutSettings.headerImageUrl>
      <#elseif layoutSettings.commonHeaderImageUrl?exists>
        <#assign headerImageUrl = layoutSettings.commonHeaderImageUrl>
      <#elseif layoutSettings.VT_HDR_IMAGE_URL?exists>
    <#assign headerImageUrl = layoutSettings.VT_HDR_IMAGE_URL.get(0)>
</#if>
<#-- Get AppBarWebInfos -->
<#if (requestAttributes.externalLoginKey)??><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey!></#if>
<#if (externalLoginKey)??><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey!></#if>
<#assign ofbizServerName = application.getAttribute("_serverId")?default("default-server")>
<#assign contextPath = request.getContextPath()>
<#assign displayApps = Static["org.ofbiz.webapp.control.LoginWorker"].getAppBarWebInfos(security, userLogin, ofbizServerName, "main")>
<#assign displaySecondaryApps = Static["org.ofbiz.webapp.control.LoginWorker"].getAppBarWebInfos(security, userLogin, ofbizServerName, "secondary")>

<#assign appModelMenu = Static["org.ofbiz.widget.model.MenuFactory"].getMenuFromLocation(applicationMenuLocation,applicationMenuName)>
<#if appModelMenu.getModelMenuItemByName(headerItem)??>
  <#if headerItem!="main">
    <#assign show_last_menu = true>
  </#if>
</#if>

<#if parameters.portalPageId?? && !appModelMenu.getModelMenuItemByName(headerItem)??>
  <#assign show_last_menu = true>
</#if>
<html lang="${docLangAttr}" dir="${langDir}" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache, no store" />
    <meta http-equiv="expires" content="-1" />
    <title>${layoutSettings.companyName}: <#if (page.titleProperty)?has_content>${uiLabelMap[page.titleProperty]}<#else>${(page.title)?if_exists}</#if></title>
    <#if layoutSettings.shortcutIcon?has_content>
      <#assign shortcutIcon = layoutSettings.shortcutIcon/>
    <#elseif layoutSettings.VT_SHORTCUT_ICON?has_content>
      <#assign shortcutIcon = layoutSettings.VT_SHORTCUT_ICON.get(0)/>
    </#if>
    <#if shortcutIcon?has_content>
      <link rel="shortcut icon" href="<@ofbizContentUrl>${StringUtil.wrapString(shortcutIcon)}</@ofbizContentUrl>" />
    </#if>
    <#if layoutSettings.VT_HDR_JAVASCRIPT?has_content>
        <#list layoutSettings.VT_HDR_JAVASCRIPT as javaScript>
            <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>
    <#if layoutSettings.javaScripts?has_content>
        <#list layoutSettings.javaScripts as javaScript>
            <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
        </#list>
    </#if>
    <#if layoutSettings.styleSheets?has_content>
        <#--layoutSettings.styleSheets is a list of style sheets. So, you can have a user-specified "main" style sheet, AND a component style sheet.-->
        <#list layoutSettings.styleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_STYLESHEET?has_content>
        <#list layoutSettings.VT_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.rtlStyleSheets?has_content && langDir == "rtl">
        <#--layoutSettings.rtlStyleSheets is a list of rtl style sheets.-->
        <#list layoutSettings.rtlStyleSheets as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_RTL_STYLESHEET?has_content && langDir == "rtl">
        <#list layoutSettings.VT_RTL_STYLESHEET as styleSheet>
            <link rel="stylesheet" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
        </#list>
    </#if>
    <#if layoutSettings.VT_EXTRA_HEAD?has_content>
        <#list layoutSettings.VT_EXTRA_HEAD as extraHead>
            ${extraHead}
        </#list>
    </#if>
    <#if layoutSettings.WEB_ANALYTICS?has_content>
      <script language="JavaScript" type="text/javascript">
        <#list layoutSettings.WEB_ANALYTICS as webAnalyticsConfig>
          ${StringUtil.wrapString(webAnalyticsConfig.webAnalyticsCode?if_exists)}
        </#list>
      </script>
    </#if>
</head>

<#if layoutSettings.headerImageLinkUrl?exists>
  <#assign logoLinkURL = "${layoutSettings.headerImageLinkUrl}">
<#else>
  <#assign logoLinkURL = "${layoutSettings.commonHeaderImageLinkUrl}">
</#if>
<#assign organizationLogoLinkURL = "${layoutSettings.organizationLogoLinkUrl?if_exists}">
<body>
  <div id="wait-spinner" style="display:none">
    <div id="wait-spinner-image"></div>
  </div>
  <div class="container-fluid">
  <div class="hide">
    <a href="#column-container" title="${uiLabelMap.CommonSkipNavigation}" accesskey="2">
      ${uiLabelMap.CommonSkipNavigation}
    </a>
  </div>
  <nav class="top-bar" data-topbar role="navigation">
    <ul class="title-area">
              <a class="navbar-brand" href="<@ofbizUrl>${logoLinkURL}</@ofbizUrl>">
                <#if headerImageUrl?exists>
                    <#if organizationLogoLinkURL?has_content>
                        <img alt="${layoutSettings.companyName}" src="<@ofbizContentUrl>${StringUtil.wrapString(organizationLogoLinkURL)}</@ofbizContentUrl>">
                    <#else>
                        <img alt="${layoutSettings.companyName}" src="<@ofbizContentUrl>${StringUtil.wrapString(headerImageUrl)}</@ofbizContentUrl>">
                    </#if>
                <#else>
                    ${layoutSettings.companyName}
                  </#if>
            </a>
    </ul>
    
    <section class="top-bar-section">
    
        <ul class="right">
          <#if userLogin?exists>
              <#if orgName?has_content>
                <li class="org">${orgName}</li>
              </#if>
              <#if userLogin.partyId?exists>
                <li class="has-dropdown">
                    <a href="#">${userName!}</a>
                    <ul class="dropdown">
                        <li><a href="<@ofbizUrl>passwordChange</@ofbizUrl>"><span class="glyphicon glyphicon-lock button-label">${uiLabelMap.CommonChangePassword}</a></li>
                        <li><a href="<@ofbizUrl>ListVisualThemes</@ofbizUrl>"><span class="glyphicon glyphicon-list button-label"></span> ${uiLabelMap.CommonVisualThemes}</a></li>
                        <li><a href="<@ofbizUrl>ListLocales</@ofbizUrl>"><span class="glyphicon glyphicon-globe button-label"></span> ${uiLabelMap.CommonLanguageTitle}</a></li>
                    </ul>
                </li>
              <#else>
                <li class="user">${userName!}</li>
              </#if>
              <#if layoutSettings.middleTopMessage1?has_content && layoutSettings.middleTopMessage1 != " ">
                <li class="has-dropdown">
                    <a href="#"> messages: ${layoutSettings.middleTopMessage1?size}</a>
                    <ul class="dropdown" role="menu">
                        <li><a href="${StringUtil.wrapString(layoutSettings.middleTopLink1!)}">${layoutSettings.middleTopMessage1?if_exists}</a></li>
                        <li><a href="${StringUtil.wrapString(layoutSettings.middleTopLink2!)}">${layoutSettings.middleTopMessage2?if_exists}</a></li>
                        <li><a href="${StringUtil.wrapString(layoutSettings.middleTopLink3!)}">${layoutSettings.middleTopMessage3?if_exists}</a></li>
                    </ul>
                </li>
              </#if>
                  <li><a href="<@ofbizUrl>logout</@ofbizUrl>">${uiLabelMap.CommonLogout}</a></li>
              <#else>
                  <li><a href="<@ofbizUrl>${checkLoginUrl}</@ofbizUrl>">${uiLabelMap.CommonLogin}</a></li>
            </#if>
          </ul>
    
        <ul class="left">
            <li class="has-dropdown not-click">
              <#if userLogin?has_content>
                  <#-- Primary Applications -->
                    <a href="#">${uiLabelMap.CommonApplications}</a>
               <ul class="dropdown">
                <#list displayApps as display>
                  <#assign thisApp = display.getContextRoot()>
                  <#assign permission = true>
                  <#assign selected = false>
                  <#assign permissions = display.getBasePermission()>
                  <#list permissions as perm>
                    <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                        <#-- User must have ALL permissions in the base-permission list -->
                        <#assign permission = false>
                    </#if>
                  </#list>
                  <#if permission == true>
                    <#if thisApp == contextPath || contextPath + "/" == thisApp>
                        <#assign selected = true>
                    </#if>
                    <#assign thisApp = StringUtil.wrapString(thisApp)>
                    <#assign thisURL = thisApp>
                    <#if thisApp != "/">
                      <#assign thisURL = thisURL + "/control/main">
                    </#if>
                    <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
                      <!-- do not display this component-->
                    <#else>
                      <li<#if selected> class="selected"</#if>><a href="${thisURL + externalKeyParam}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a></li>
                    </#if>
                  </#if>
                </#list>
               </ul>
            </li><#-- Primary Applications dropdown ends-->
                
            <li class="has-dropdown not-click"><#-- Secondary Applications -->
                <a href="#">${uiLabelMap.CommonMore}</a>
                <ul class="dropdown">
                    <#list displaySecondaryApps as display>
                        <#assign thisApp = display.getContextRoot()>
                        <#assign permission = true>
                        <#assign selected = false>
                        <#assign permissions = display.getBasePermission()>
                        <#list permissions as perm>
                            <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                                <#-- User must have ALL permissions in the base-permission list -->
                                <#assign permission = false>
                            </#if>
                        </#list>
                        <#if permission == true>
                            <#if thisApp == contextPath || contextPath + "/" == thisApp>
                                <#assign selected = true>
                            </#if>
                            <#assign thisApp = StringUtil.wrapString(thisApp)>
                            <#assign thisURL = thisApp>
                            <#if thisApp != "/">
                                <#assign thisURL = thisURL + "/control/main">
                            </#if>
                            <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
                                <!-- do not display this component-->
                            <#else>
                                <li<#if selected> class="selected"</#if>><a href="${thisURL + externalKeyParam}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a></li>
                            </#if>
                        </#if>
                    </#list>
                </ul>
            </li><#-- Secondary Applications ends -->
            
                  <#--if webSiteId?exists && requestAttributes._CURRENT_VIEW_?exists && helpTopic?exists-->
                  <#if parameters.componentName?exists && requestAttributes._CURRENT_VIEW_?exists && helpTopic?exists>
                    <#include "component://common/webcommon/includes/helplink.ftl" />
                    <li>
                        <a class="btn <#if pageAvail?has_content> btn-default</#if> navbar-btn " href="javascript:lookup_popup1('showHelp?helpTopic=${helpTopic}&amp;portalPageId=${parameters.portalPageId?if_exists}','help' ,500,500);" title="${uiLabelMap.CommonHelp}"></a>
                    </li>
                  </#if>
              </#if>
          </ul>
          
      </section>
  </nav>
  
  <#--<br class="clear" />-->
