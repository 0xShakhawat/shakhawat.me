---
title: "Query Parameters"
description: Query Parameters.
weight: 7
draft: false
showDate: false
---
## Query Parameters

In addition to the request method and URL, many APIs utilize query parameters to refine requests.  Query parameters are key-value pairs that provide additional information to the server.

### Query Parameter Syntax

Query parameters are appended to the request URL's path. They begin with a question mark (`?`) followed by key-value pairs in the format `key=value`. Multiple parameters are separated by ampersands (`&`).

**Examples:**

* `GET https://some-api.com/photos?orientation=landscape` (Single parameter)
* `GET https://some-api.com/photos?orientation=landscape&size=500x400` (Multiple parameters)

### Example: Google Search

A Google search utilizes query parameters.  The URL `https://www.google.com/search?q=postman` uses the parameter `q=postman` to specify the search term. The server then returns an HTML page with search results for "Postman."  Modifying the value of `q` changes the search query.

### When to Use Query Parameters

API documentation dictates when and how to use query parameters. They may be optional filters or required for request processing.

The Postman Library API v2 allows optional query parameters on `GET /books` requests to filter responses.

### Filtering Books by Genre

This example demonstrates filtering book results by genre.

1. In the Postman Library API v2 collection, duplicate the "get books" request.
2. Rename the duplicated request to "get fiction books."
3. In the "Params" tab, add a query parameter with the key `genre` and the value `fiction`. Postman automatically adds the question mark (`?`).
4. Save and send the request.

The response should contain only books with the `fiction` genre.  Experimenting with different genre values is encouraged.

![Fintering Books](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F4qlhnpfiaeqby6zwhuhhmacvx%2Fpublic%2F1694580643%2FScreen+Recording+2023-09-13+at+10.17.08+AM.1694580642910.gif)

### Using Multiple Query Parameters

This example adds a second query parameter to filter for available books (not checked out).

1. In the "get fiction books" request, add another query parameter in the "Params" tab with the key `checkedOut` and the value `false`.
2. Save and send the request.

The response should contain only fiction books where the `checkedOut` property is `false`.  This might return an empty array (`[]`) if no such books exist.  Saving the request before proceeding is recommended.

![Multiple Query Parameters](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649552322%2FcheckedOut+false+response.1649552322319.png)

---