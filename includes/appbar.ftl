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
<#assign appModelMenu = Static["org.ofbiz.widget.model.MenuFactory"].getMenuFromLocation(applicationMenuLocation,applicationMenuName)>
<#assign modelMenus = Static["org.ofbiz.widget.model.MenuFactory"].getMenusFromLocation(applicationMenuLocation)>

<#assign menus = modelMenus.keySet()>
<#assign menuItemList = appModelMenu.menuItemList>
<#if menuItemList?has_content>
    <div class="large-12 columns">
    <nav class="AppBar" data-topbar role="appbar">
        <section>
        <ul class="button-group appbar" role="MainAppBar" title="">
            <#list menuItemList as item>
                <#assign name = item.name>
                <#assign title = item.getTitle(context)>
                <#if (item.getLink().getTarget(context))?has_content>
                    <#assign target = item.getLink().getTarget(context)>
                    <#else>
                        <#if item.getParentPortalPageId(context)?has_content>
                            <#assign parentPortalPageId = item.getParentPortalPageId(context)>
                            <#assign portalPages = Static["org.ofbiz.widget.PortalPageWorker"].getPortalPages(parentPortalPageId, context)>
                            <#list portalPages as portalPage>
                                <#assign name = portalPage.portalPageName>
                                <#assign link = "showPortalPage?portalPageId=${portalPage.portalPageId}">
                                <#if portalPage.parentPortalPageId?has_content>
                                    <#assign target = link+"&amp;parentPortalPageId=${portalPage.parentPortalPageId?if_exists}">
                                    <#else>
                                        <#assign target = link>
                                </#if>
                                <li>
                                    <a href="<@ofbizUrl>${target?if_exists}</@ofbizUrl>" class="button">${portalPage.get("portalPageName",locale)}</a>
                                </li>
                            </#list>
                        </#if>
                </#if>
                
                <#-- Get TabBar submenu based on menu name -->
                <#assign subMenuName = "${name}TabBar">
                <#if menus?seq_contains("${subMenuName}")>
                    <#assign subModelMenu = Static["org.ofbiz.widget.model.MenuFactory"].getMenuFromLocation(applicationMenuLocation,subMenuName)>
                    <#if subModelMenu?has_content>
                        <#assign subMenuItemList = subModelMenu.menuItemList>
                        <#if subMenuItemList?has_content>
                            <li class="has-dropdown">
                                <a href="<@ofbizUrl>${target?if_exists}</@ofbizUrl>" class="button tiny tabbar"</a>
                                <ul class="dropdown">
                                    <#list subMenuItemList as subMenuItem>
                                        <#assign name = subMenuItem.name>
                                        <#assign title = subMenuItem.getTitle(context)>
                                        <#assign target = subMenuItem.getLink().getTarget(context)>
                                    </#list>
                                </ul>
                            </li>
                        </#if>
                    </#if>
                <#elseif menus?seq_contains("${subMenuName?cap_first}")>
                    <#assign subMenuName = "${subMenuName?cap_first}">
                    <#assign subModelMenu = Static["org.ofbiz.widget.model.MenuFactory"].getMenuFromLocation(applicationMenuLocation,subMenuName)>
                    <#if subModelMenu?has_content>
                        <#assign subMenuItemList = subModelMenu.menuItemList>
                        <#if subMenuItemList?has_content>
                            <li class="has-dropdown">
                                <a href="<@ofbizUrl>${target}</@ofbizUrl>" class="button tiny tabbar"</a>
                                <ul class="dropdown">
                                    <#list subMenuItemList as subMenuItem>
                                        <#assign name = subMenuItem.name>
                                        <#assign title = subMenuItem.getTitle(context)>
                                        <#assign target = subMenuItem.getLink().getTarget(context)>
                                    </#list>
                                </ul>
                            </li>
                        </#if>
                    </#if>
                <#else>
                    <#if name == "main">
                        <li>
                            <a href="<@ofbizUrl>${target?if_exists}</@ofbizUrl>" class="button tiny">${applicationTitle}</a>
                        </li>
                        <#else>
                            <li>
                            <a href="<@ofbizUrl>${target?if_exists}</@ofbizUrl>" class="button tiny">${title?if_exists}</a>
                            </li>
                    </#if>
                </#if>
            </#list>
        </ul>
        </section>
    </nav>
</#if>