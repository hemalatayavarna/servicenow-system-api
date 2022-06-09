%dw 2.0
import p from Mule
output application/json
var data = vars.originalPayload.leaders
var country = p('default.work.country')
var timeZone = p('default.timezone')

var upperCharSet = p('password.upper.character.set')
var lowerCharSet = lower(upperCharSet)
var numberSpecialCharSet = p('password.number.special.character.set')
var charSetLength = sizeOf(upperCharSet) - 1
var numberSpecialCharSetLength = sizeOf(numberSpecialCharSet) - 1
var passwordSectionLength = p('password.section.length') as Number

fun generatePassword() =
  (1 to passwordSectionLength map upperCharSet[randomInt(charSetLength)] joinBy '') ++  
  (1 to passwordSectionLength map lowerCharSet[randomInt(charSetLength)] joinBy '') ++
  (1 to passwordSectionLength map numberSpecialCharSet[randomInt(numberSpecialCharSetLength)] joinBy '')
---
data map ((item, index) -> 
{
    "userName": (item.email splitBy('@'))[0],
    "password": generatePassword(),
    "firstName": item.firstName,
    "lastName": item.lastName,
    "workCountry": country,
    "timezone": timeZone,
    "workEmailAddress1": item.email
})