---
title: "Variables in Postman"
description: Variables in Postman.
weight: 6
draft: false
showDate: false
---
## Working with Variables in Postman

Variables in Postman allow storing and reusing values, which helps keep requests organized and simplifies updates. They are also essential for managing sensitive data like API keys. Variables are accessed using double curly brace syntax: `{{variableName}}`.

### Setting a `baseUrl` Variable

Creating a variable to store the base URL of the Postman Library API avoids repetitive typing and makes it easier to update the URL if it changes.

1. Open the "get books" request (or any request in the collection).
2. Select the base URL portion of the request URL (`https://library-api.postmanlabs.com`). Do not include the trailing slash.
3. Click the "Set as variable" popup that appears. ![Set as variable](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649630820%2FbaseUrl+1.1649630820044.png)
4. Choose "Set as a new variable". ![Set as new variable](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649630940%2FbaseUrl+2.1649630940824.png)
5. Enter "baseUrl" as the variable name.
6. Select "Collection" as the scope (this makes the variable accessible to all requests within the collection).
7. Click "Set variable."

The base URL in the request URL can now be replaced with `{{baseUrl}}`. For example: `{{baseUrl}}/books`. Hovering over the variable displays its current value.

### Accessing Variables

The `{{variableName}}` syntax can be used anywhere in requests (URL, headers, body, etc.) to access the variable's value.

### Viewing and Managing Variables

1. Click on the collection in the sidebar.
2. Select the "Variables" tab. ![Collection Variables](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649631322%2FbaseUrl+3.1649631322119.png)

Two columns will be displayed:

* **Initial Value:** The value shared when the collection is exported or forked. *Do not store sensitive information here.*
* **Current Value:** The value used by Postman when running requests. This value is local to the Postman instance and is a suitable location for storing API keys or other secrets.


---