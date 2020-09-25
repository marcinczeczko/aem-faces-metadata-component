<%@include file="/libs/granite/ui/global.jsp"%><%
%><%@page session="false"
          import="org.apache.sling.api.resource.Resource,
                  com.adobe.granite.ui.components.AttrBuilder,
                  com.adobe.granite.ui.components.Tag,
                  com.day.cq.dam.commons.util.UIHelper,
                  com.day.cq.dam.api.Asset,
				  com.day.cq.dam.api.DamConstants" %>
<%
%><%@include file="/libs/dam/gui/coral/components/admin/contentrenderer/base/base.jsp"%>
<%

    if (!cmp.getRenderCondition(resource, false).check()) {
        return;
    }

    Tag tag = cmp.consumeTag();
    AttrBuilder attrs = tag.getAttrs();
    attrs.addClass("foundation-collection-item foundation-selections-item metadata-editor-facescard");
    cmp.populateCommonAttrs(attrs);

    Resource assetresource = resourceResolver.getResource(((String[]) request.getAttribute("aem.assets.ui.properties.content"))[0]);
    Asset asset = assetresource !=null ? assetresource.adaptTo(Asset.class) : null;

    if (asset != null) {
        long ck = UIHelper.getCacheKiller(assetresource.adaptTo(Node.class));
        String thumbnailUrl = request.getContextPath()
                              + getThumbnailUrl(asset, 1280, true, true, sling)
                              + "?ch_ck=" + ck;

        String height = asset.getMetadata(DamConstants.TIFF_IMAGELENGTH) != null? asset.getMetadata(DamConstants.TIFF_IMAGELENGTH).toString(): null;
        String width = asset.getMetadata(DamConstants.TIFF_IMAGEWIDTH ) != null? asset.getMetadata(DamConstants.TIFF_IMAGEWIDTH ).toString(): null;

        Integer facesCount = asset.getMetadata("faces:count") != null ? Integer.parseInt(asset.getMetadata("faces:count").toString()) : 0;
        String facesData = asset.getMetadata("faces:faces") != null ? asset.getMetadata("faces:faces").toString() : "[]";
        String messageClass = facesCount > 0 ? "faces-found" : "faces-notfound";
%>
   <coral-masonry class="cq-damadmin-admin-childpages foundation-collection">
        <h3 class="<%= messageClass %>"><%= facesCount %> face(s) recognized</h3>
<%   if (facesCount > 0) { %>
		<div class="facescard cq-damadmin-admin-childpages foundation-collection">
            <canvas class="facesCanvas" id="facesCanvas"
                    width="<%= width %>"
                    height="<%= height %>"
                    data-image="<%= xssAPI.encodeForHTMLAttr(thumbnailUrl) %>"
                    data-faces='<%= facesData %>'></canvas>
        </div>
<%   }%>
   </coral-masonry>
    <% } %>

