%dw 2.0
output application/json
---
{
    message: "Hello patient " ++ (attributes.queryParams.name default "stranger") ++ "!!!"
}