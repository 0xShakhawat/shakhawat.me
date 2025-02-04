---
title: "Path Variables"
description: Path Variables.
weight: 8
draft: false
showDate: false
---
## Path Variables

Path variables (or path parameters) are dynamic parts of a URL path, often used to represent identifiers like IDs or usernames.

### Path Variable Syntax

Path variables are placed directly within the URL path, typically following a forward slash (`/`).  They are often represented using curly braces `{}` or sometimes colons `:`.

**Examples:**

* `GET https://api.github.com/users/{username}`
* `GET https://api.github.com/repos/{owner}/{repoName}`

Substituting values for the placeholders creates specific API calls:

* `GET https://api.github.com/users/postmanlabs` (Fetches data for the user "postmanlabs")
* `GET https://api.github.com/repos/postmanlabs/newman` (Fetches data for the "newman" repository owned by "postmanlabs")


### Path vs. Query Parameters

| Feature         | Path Variable                        | Query Parameter                                |
|-----------------|------------------------------------|-----------------------------------------------|
| Location       | Within the URL path                 | Appended to the URL path after a `?`          |
| Purpose        | Often used for IDs or entity names   | Often used for filters and options           |
| Example         | `/books/abc123`                       | `/books?search=borges&checkedOut=false`     |


It is important to note these are conventions. Some APIs might require IDs or usernames to be passed as query parameters.

### When to Use Path Variables

Refer to the API documentation to determine if and how to use path variables.  Documentation may use either curly braces `{}` or colons `:` to denote path variables; both indicate a dynamic path segment.

### Retrieving a Book by ID

The Postman Library API v2 uses path variables to retrieve specific books by their unique IDs.

1. In the Postman Library API v2 collection, add a new request and name it "get book by id."
2. Set the request method to `GET`.
3. Set the request URL to `{{baseUrl}}/books/:id`. Postman will automatically create a "Path Variables" editor in the "Params" tab.
4. In the "Params" tab, enter the book's ID (e.g., `29cd820f-82f9-4b45-a7f4-0924111b5b89` for "Ficciones") as the value for the `id` variable. Ensure no extra whitespace is included.
   ![ID Value](https://whimuc.com/PwqrrQiv3tT4JsqRDkan2a/3uZbaXTZ6TAhMv.png)
5. Save and send the request.

A successful request returns a 200 OK response with a JSON object representing the specified book.
   ![Response with ID](https://whimuc.com/PwqrrQiv3tT4JsqRDkan2a/ApVSsJNYMMug2R.png)


### Debugging with the Postman Console

The Postman Console, located in the lower left corner of Postman, logs all requests and responses. It can be used to inspect the raw request sent to the API, which is useful for debugging.  Expanding the most recent request shows how Postman substitutes the `:id` placeholder with the provided ID value.  This helps identify errors, such as accidental whitespace in parameter values.

![Console Log](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F4qlhnpfiaeqby6zwhuhhmacvx%2Fpublic%2F1727268082%2Fmain.1727268082127.png)

---