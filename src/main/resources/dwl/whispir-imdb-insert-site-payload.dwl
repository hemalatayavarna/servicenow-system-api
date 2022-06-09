%dw 2.0
import p from Mule

output application/json

var data = vars.originalPayload
var pgP = vars.originalPayload.guardianContactPreference
var guardianPrimary = p('whispir.guardian_preference.primary')
var guardianBoth = p('whispir.guardian_preference.both')
var imddbTrue = p('imddb.true') as Boolean
var imddbFalse = p('imddb.false') as Boolean
---
{
	"orgUnitId": data.billingCode default "",
	"orgUnitName": data.orgName default "",
	"whispirWorkspaceId": vars.whispirWorkspaceId,
	"description": data.description default "",
	"billingCode": data.billingCode default "",
	"aliasName": data.alias.emailFrom default "",
	"aliasSmsFrom": data.alias.smsFrom default "",
	"aliasSmsSenderId": data.alias.smsSenderId default "",
	"aliasEmailAddress": data.alias.emailAddress default "",
	"parentGuardian1": if (pgP == guardianPrimary or pgP == guardianBoth) imddbTrue else imddbFalse,
	"parentGuardian2": if (pgP == guardianBoth) imddbTrue else imddbFalse
}