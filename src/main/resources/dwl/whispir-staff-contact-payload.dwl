%dw 2.0
import p from Mule

output application/json
var data = payload.payload
var timeZone = p('default.timezone.offset')
var country = p('default.work.country')
var employeeRole = p('default.employee.role')
fun assignOrgUnits(item) =
  item.mainOrgUnitName // for MVP only the main org, for next release all the schools will be added
---
data map ((item, index) -> {
	"firstName": trim(item.firstName),
	"lastName": trim(item.lastName),
	"workMobilePhonePrimary": item.workMobile,
	"workEmailAddressPrimary": item.workEmail,
	"workCountry": country,
	"timezone": timeZone,
	"role": employeeRole,
	"additionalRole": assignOrgUnits(item),
	"organizationName": item.mainOrgUnitName,
	"division": item.mainOrgUnitId
})