# Continue to output logs - SilentlyContinue to keep going
$GLOBAL:DebugPreference="SilentlyContinue"

#This script will remove the consented permissions on a service principal for a specific resource.
#For example, to remove the MS Graph Permission, AuditLog.Read.All Admin Consent from the Graph Explorer Tool
#To prevent issues with duplicate display names, which is possible, you can look up the app id or service principal id in
#the enterprise applications blade in the Azure portal.

$SPtoRemoveConsentOn        = "de8601aa-154e-44c0-a602-d74d11143ce0"
$resourceAppIdThatOwnsScope = "00000003-0000-0000-c000-000000000000"
$scopeToRemove              = "AuditLog.Read.All"

Connect-MgGraph

#need to get the service principal object id for Microsoft Graph
# graph request being made: GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=appId eq '00000003-0000-0000-c000-000000000000'
$resourceSP = Get-MgServicePrincipal -Filter "appId eq '$resourceAppIdThatOwnsScope'"
$resourceId = $resourceSP.Id
"--> Resource Service Principal ID for your tenant:                         " + $resourceId

# graph request being made: GET https://graph.microsoft.com/v1.0/oauth2PermissionGrants?$filter=clientId eq 'de8601aa-154e-44c0-a602-d74d11143ce0' and ConsentType eq 'AllPrincipals' and resourceId eq 'e2ef5b0a-7ba9-4c34-9d9a-581dd1e0292b'
$spOAuth2PermissionsGrants = Get-MgOauth2PermissionGrant -Filter "clientId eq '$SPtoRemoveConsentOn' and ConsentType eq 'AllPrincipals' and resourceId eq '$resourceId'"
Write-Host("OAuth2 Permission Grant Object:")
($spOAuth2PermissionsGrants)|FL

$scope = $spOAuth2PermissionsGrants.Scope
"--> Permissions for this resource with Admin Consent:                      " + $scope

#get the specific oauth2permission grant id we are working with now
$consentId = $spOAuth2PermissionsGrants.Id
"--> Specific Oauth2PermissionGrant id we will be updating:                 " + $consentId

#remove the admin consent we don't want from the string -- in this case, AuditLog.Read.All
$scope = $scope.Replace($scopeToRemove,"")
"--> New scope value:                                                       " + $scope

#update the service principal with the new list of scopes
# Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId $consentId -Scope $scope.Trim(" ")

# graph request that was made in the end:
# PATCH https://graph.microsoft.com/v1.0/oauth2PermissionGrants/qgGG3k4VwESmAtdNxxxxxxxxxxxxxxxxdHgKSs
# body used:
# {
#   "scope": "openid profile offline_access"
# }