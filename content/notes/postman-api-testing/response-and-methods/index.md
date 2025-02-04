---
title: "Response and Methods"
description: Response and Methods.
weight: 5
draft: false
showDate: false
---
### Viewing the Response:

The response will appear in the lower pane.  It should be a JSON array of book objects.  The specific books may vary as the database is live and updated by other users.

![Screenshot: Viewing the response](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649283511%2Fget+books+response.1649283511929.png)

### Understanding Request Methods (HTTP Verbs):

Request methods define the action to be performed on the server. Common methods include:

* `GET`: Retrieve data (Read).
* `POST`: Send data (Create).
* `PUT`: Update data (Update - usually replaces the entire resource).
* `PATCH`: Update data (Update - typically for partial updates).
* `DELETE`: Delete data (Delete).

Always consult the API documentation for the correct method to use for a specific endpoint.

### Understanding Request URLs:

A request URL specifies the location of the API endpoint. It has three parts:

* **Protocol:** `https://` (or `http://`)
* **Host:** `library-api.postmanlabs.com`
* **Path:** `/books`

The combination of host and path is often referred to as the API endpoint.


### Understanding Response Status Codes:

Status codes indicate the outcome of a request.

* **2xx Success:**  e.g., 200 OK, 201 Created, 204 No Content.
* **3xx Redirection:** e.g., 301 Moved Permanently.
* **4xx Client Error:**  e.g., 400 Bad Request, 401 Unauthorized, 404 Not Found.
* **5xx Server Error:**  e.g., 500 Internal Server Error.

Hover over the status code in Postman to see its description.

![Screenshot: Response Code](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649284684%2Fstatus+200.1649284683906.png)

### The Request-Response Pattern:

This is the fundamental communication model in web APIs:
![Screenshot: Request-Response Pattern](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649285301%2Frequest+response+pattern.1649285301835.png)
1. **Client (Postman in this case) sends a request** over the network.
2. **Server receives the request,** processes it, and generates a response.
3. **Server sends the response** back to the client over the network.

---
