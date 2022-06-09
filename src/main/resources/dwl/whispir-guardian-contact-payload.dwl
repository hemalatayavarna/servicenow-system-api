%dw 2.0
import p from Mule

output application/json
var data = payload
var timeZone = p('default.timezone.offset')
var country = p('default.work.country')
var patternChar = p('whispir.distributionlists.pattern_character')

fun getRole(role) =
    if (role == 1)
        p('guardian.role.primary')
    else if (role == 2)
        p('guardian.role.secondary')
    else
        null
        
fun getRollClasses(edId) =
	(vars.enrolmentPayload.payload filter ((item, index) ->
		item.edId == edId
	)).rollClass joinBy ("$(patternChar) $(patternChar)")

---
data map ((item, index) -> {
	"firstName": trim(item.guardianFirstName),
	"lastName": trim(item.guardianLastName),
	"workMobilePhonePrimary": item.guardianMobile,
	"workEmailAddressPrimary": item.guardianEmail,
	"workCountry": country,
	"timezone": timeZone,
	"role": getRole(item.guardianRole),
	"additionalRole": "$(patternChar)$(getRollClasses(item.edId))$(patternChar)",
	"organizationName": "",
	"division": vars.orgUnitId
})