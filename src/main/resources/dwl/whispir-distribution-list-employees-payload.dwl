%dw 2.0
import p from Mule

output application/json
---
{
  "name" : p('whispir.distributionlists.employees'),
  "description" : p('whispir.distributionlists.employees'),
  "access" : p('whispir.distributionlists.access'),
  "visibility" : p('whispir.distributionlists.visibility'),
  "type":  p('whispir.distributionlists.type'),
  "entityType": p('whispir.distributionlists.entity_type'),
  "rules": [
    {
      "ruleFilter": p('whispir.distributionlists.employees.rule_filter1'),
      "ruleFilterActualName": p('whispir.distributionlists.employees.rule_filter_actual_name1'),
      "ruleContent": p('whispir.distributionlists.employees.rule_content1')
    },
    {
      "ruleFilter": p('whispir.distributionlists.employees.rule_filter2'),
      "ruleFilterActualName": p('whispir.distributionlists.employees.rule_filter_actual_name2'),
      "ruleContent": vars.originalPayload.orgName
    }
  ]
}