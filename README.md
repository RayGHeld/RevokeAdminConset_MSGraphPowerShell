# RevokeAdminConset_MSGraphPowerShell
Revoke Admin Consent for a permission on a Service Principal with the MS Graph PowerShell SDK

<!-- wp:paragraph -->
<p>Scenario: You use the Microsoft Graph Explorer tool to test a query.  It requires you to consent to a permission so you use your admin account to do this.  However, you click the check box to consent for the entire organization... woops!  You did not mean to give everyone permissions for "AuditLog.Read.All" so now you need to revoke this permission.  The easiest way to revoke consent is to just delete the service principal, however, if there are custom settings or individual consents already applied, then you will lose those as well when the service principal is deleted.  What is the solution?  Use the Microsoft Graph PowerShell SDK to remove that consented permission from the service principal.  This blog post will show you how to revoke permissions using the Microsoft Graph PowerShell SDK.  I will use the MS Graph Explorer tool's service principal as an example however, this technique can be used to revoke permissions for any resource on a Service Principal.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Step 1) You need to find the service principal in Enterprise Applications blade for your MS Graph Explorer tool. You can find that by going to <a href="https://portal.azure.com/#view/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/~/AppAppsPreview/menuId~/null" target="_blank" rel="noreferrer noopener">here </a> after signing in to the portal.  Then, in the search box, type in "Graph Explorer" and find the entry that has the Homepage URL of https://developer.microsoft.com/graph/graph-explorer -- it will also have the Application ID: de8bc8b5-d9f9-48b1-a8ad-b748da725064.  Copy that Object Id to the clipboard.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":8927,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="/wp-content/uploads/2022/06/image-1024x188.png" alt="" class="wp-image-8927"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Step 2) Enter that object Id in the PowerShell script variable $SPtoRemoveConsentOn as in this image:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":8928,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="/wp-content/uploads/2022/06/image-1.png" alt="" class="wp-image-8928"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Step 3) Add the app id that owns the permission.  For this example, the MS Graph Resource owns the permission that we are removing so that is the variable $resourceAppThatOwnsScope.  You can leave that as is for any Microsoft Graph Permission.  If you have created your own permission or are removing a permission for a different resoruce, then you will need the app id that owns the permission.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Step 4)  Set the variable $sopeToRemove.  For our example, we are removing the scope "AuditLog.Read.All"</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>That is all that is needed to be set for this example.  For the sake of safety, the Update command has been commented out so that you can verify your details before actually executing the script.  Once you're satisfied with the output, you can uncomment the command "Update-MgOauth2PermissionsGrant" to execute the change.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>I have included in the script the actual commands that will be ran for each step, so you can compare them with my output.  My output ( without running the update ):<br></p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":8930,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="/wp-content/uploads/2022/06/image-3.png" alt="" class="wp-image-8930"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>You can find my PowerShell script here in my GitHub.  Line 38 in the script is the update line that should be uncommented when you're ready to actually execute the change.</p>
<!-- /wp:paragraph -->
