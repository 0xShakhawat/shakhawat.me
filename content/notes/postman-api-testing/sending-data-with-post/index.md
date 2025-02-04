---
title: "Sending data with POST"
description: Sending data with POST.
weight: 9
draft: false
showDate: false
---
## Sending Data with POST

The `POST` method is used to send data to an API endpoint, often to create a new resource. This section demonstrates adding a new book to the Postman Library API using a `POST` request and a JSON body.

### Request Body

The request body contains the data sent to the server.  It's commonly used with `POST`, `PUT`, and `PATCH` requests.  Postman's "Body" tab allows specifying various body data types.  The "raw" type with the "JSON" option is used in this example.

### Adding a Book

1. In the Postman Library API v2 collection, add a new request named "add book."
2. Set the request method to `POST`.
3. Set the request URL to `{{baseUrl}}/books`.
4. In the "Body" tab, select "raw" and then "JSON" from the dropdown.
5. Enter a JSON object representing the new book. Example:

```json
{
  "title": "To Kill a Mockingbird",
  "author": "Harper Lee",
  "genre": "fiction",
  "yearPublished": 1960
}
```

6. Save and send the request.

Initially, a `401 Unauthorized` response might be received. This indicates missing authorization.
   ![401 Unauthorized Response](https://whimuc.com/PwqrrQiv3tT4JsqRDkan2a/BdRh1xGJbRu2ut.png)


### Adding an Authorization Header

Many APIs require authorization to protect sensitive operations. The Postman Library API uses API keys for authorization.

#### Authorization Methods

Several authorization methods exist, including Basic Auth (username/password), OAuth (delegated authorization), and API Keys.

#### API Keys

APIs using API Key authorization often require registration on a developer portal to obtain a unique key.  The Postman Library API uses a predefined key for simplicity.

* **Header Name:** `api-key`
* **Header Value:** `postmanrulz`

#### Request Headers

Headers provide metadata about a request, such as authorization information or desired response data type.  They are distinct from the request body.

### Adding the API Key

1. In the "add book" request, go to the "Headers" tab.
2. Add the key `api-key` with the value `postmanrulz`.
3. Save and send the request.

A successful request returns a `201 Created` response with the new book's data, including a unique `id`.

### Viewing the New Book (Optional)

The new book can be retrieved using the "get book by id" request with the newly assigned ID.
   ![Retrieving New Book](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F4qlhnpfiaeqby6zwhuhhmacvx%2Fpublic%2F1694705364%2FScreen+Recording+2023-09-14+at+8.58.07+PM.1694705364341.gif)

### Using Postman's Authorization Helper

Postman provides an authorization helper to simplify the process.

1. In the "add book" request, delete the manually added `api-key` header.
2. Select the Postman Library API v2 collection.
3. Go to the "Authorization" (or "Auth") tab.
4. Select "API Key" as the authorization type.
5. Enter `api-key` as the Key and `postmanrulz` as the Value. Set "Add to" as "Header."
6. Save the collection.

Now, all requests within the collection inheriting authorization from the parent will include the `api-key` header.

### Adding Another Book

1. Modify the request body in the "add book" request with new book details.
2. Ensure the "Authorization" tab is set to "Inherit auth from parent."
3. Save and send the request.
   ![Adding Another Book](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F4qlhnpfiaeqby6zwhuhhmacvx%2Fpublic%2F1694549627%2FScreen+Recording+2023-09-13+at+1.42.03+AM.1694549627605.gif)

The "get book by id" request can be used to retrieve the newly added book.

---

