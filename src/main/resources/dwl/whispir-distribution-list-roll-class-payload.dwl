%dw 2.0
import p from Mule

output application/json

var patternChar = p('whispir.distributionlists.pattern_character')
var rollClass:String = payload.rollClass as String default ""
// Whispir DL API does not accept special characters in the name
var dlName:String = trim(rollClass replace /[^a-z0-9A-Z]/ with " ")
var dlPrefix:String = p('whispir.distributionlists.prefix')
---
{
  "name": "$(dlPrefix) $(dlName)",
  "description": payload.rollClassDescription,
  "access": p('whispir.distributionlists.access'),
  "visibility": p('whispir.distributionlists.visibility'),
  "type":  p('whispir.distributionlists.type'),
  "entityType": p('whispir.distributionlists.entity_type'),
  "rules": [
    {
      "ruleFilter": p('whispir.distributionlists.rule_filter.role2'),
      "ruleFilterActualName": p('whispir.distributionlists.rule_filter_actual_name.role2'),
      "ruleContent": "$(patternChar)$(rollClass)$(patternChar)"
    },
    {
      "ruleFilter": p('whispir.distributionlists.rule_filter.do_contact'),
      "ruleFilterActualName": p('whispir.distributionlists.rule_filter_actual_name.do_contact'),
      "ruleContent": p('whispir.distributionlists.rule_content.do_contact')
    }
  ]
}