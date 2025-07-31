%dw 2.0
output application/json
---
{
    message: "Hello " ++ (attributes.queryParams.name default "stranger") ++ "!!!"
}