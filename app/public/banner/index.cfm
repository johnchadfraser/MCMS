<!---If a banner is called display it via script.--->
<cfobject name="bannerObj" component="MCMS.component.app.banner.Banner">
<cfoutput>
#bannerObj.setBanner(URL.taskBannerRef)#
</cfoutput>
