---
title: "Introduction to variables and scripting"
description: Introduction to variables and scripting.
weight: 10
draft: false
showDate: false
---
## Introduction to Variables and Scripting

This section expands on using variables in Postman and introduces scripting for dynamic request behavior.

### Variables in Postman (Continued)

Variables store reusable values, promoting DRY (Don't Repeat Yourself) principles and protecting sensitive data like API keys.

### Variable Scopes

Postman variables have different scopes, affecting their accessibility:

* **Global:** Accessible in all workspaces.
* **Collection:** Accessible within a collection.
* **Environment:** Accessible within an environment.
* **Data:** Used with data files for running multiple iterations of a request.
* **Local:**  Specific to a single request or script.

Postman resolves variable values based on the narrowest available scope.  This section focuses on collection variables.

### Scripting in Postman

Postman scripts add dynamic behavior to collections. Scripts execute during two events:

1. **Pre-request Script:** Runs before a request is sent.
2. **Post-request Script:** Runs after a response is received.

This section focuses on post-request scripts.

### The `pm` Object

The `pm` object provides access to Postman data, including the response body, variables, and utilities.

* `pm.response.json()`: Accesses the JSON response body.
* `pm.collectionVariables.get("variableName")`: Retrieves a collection variable's value.
* `pm.collectionVariables.set("variableName", "variableValue")`: Sets a collection variable.


### Your First Script

This task introduces a simple post-request script.

1. In the "add book" request, modify the book data in the "Body" tab.
2. In the "Tests" tab, add the following JavaScript code:

```javascript
console.log(pm.response.json());
```
3. Save and send the request.

The response data will be logged to the Postman Console.
   ![Postman Console](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1719586345%2Fimage+%2889%29.1719586345027.png)
   ![Expanded Console Object](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1719586412%2Fimage+%2891%29.1719586412618.png)



### Capturing the New Book ID

This task demonstrates setting a variable using a post-request script.

### Setting and Getting Collection Variables

* `pm.collectionVariables.set("variableName", value)`: Sets a collection variable.
* `pm.collectionVariables.get("variableName")`: Retrieves a collection variable.

### Local Variables

JavaScript `const` (for constant values) or `let` (for variable values) keywords can be used to declare local variables within scripts.

### Setting the New Book ID as a Variable

1. In the "add book" request, modify the book data.
2. In the "Tests" tab, replace the previous script with:

```javascript
// Save the ID from the response
const id = pm.response.json().id;
// Store the ID as a collection variable
pm.collectionVariables.set("id", id);
```

   ![Post-request Script](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1719600836%2Fimage+%2895%29.1719600836771.png)


3. Save and send the request.

The book's ID from the response is now stored in the `id` collection variable. This can be verified in the collection's "Variables" tab.  This `{{id}}` variable can now be used in other requests within the collection.
    ![Collection Variable "id"](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649770495%2Fset+id+2.1649770495600.png)


---


