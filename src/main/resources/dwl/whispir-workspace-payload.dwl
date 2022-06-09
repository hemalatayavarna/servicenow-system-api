%dw 2.0
import p from Mule
output application/json
var data = vars.originalPayload
---
{
  "projectName": data.orgName,
  "projectNumber": data.billingCode,
  "status": if (data.status == p('service.desk.constant.active')) p('whispir.constant.active') else p('whispir.constant.disabled'),
  "billingCostCentre": data.billingCode
}