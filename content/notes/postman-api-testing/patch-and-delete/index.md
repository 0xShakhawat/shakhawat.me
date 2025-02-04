---
title: "PATCH and DELETE"
description: PATCH and DELETE.
weight: 11
draft: false
showDate: false
---

## PATCH and DELETE Requests

This section covers using `PATCH` requests to update resources and `DELETE` requests to remove them, focusing on the Postman Library API.

### Updating a Book (Checking Out)

The `PATCH` method allows partial updates to a resource.  This example demonstrates updating a book's `checkedOut` status.

1. In the Postman Library API v2 collection, add a new request named "checkout a book."
2. Set the request method to `PATCH`.
3. Set the request URL to `{{baseUrl}}/books/:id`.
4. In the "Params" tab, set the `id` path variable to `{{id}}` (using the collection variable set previously).
   ![Setting Path Variable](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649786360%2Fcheckout+2.1649786360490.png)
5. In the "Body" tab, select "raw" and "JSON," then add the following JSON:

```json
{
  "checkedOut": true
}
```

6. Save and send the request.

The response should be a 200 OK with the updated book data showing `checkedOut: true`.  The inherited collection-level authorization applies to this request.

   ![checkedOut: true](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1719601008%2Fimage+%2896%29.1719601008533.png)


The updated data can also be verified using the "get book by id" request.


### Deleting a Book

The `DELETE` method removes a resource.  This example demonstrates deleting a book.

1. In the Postman Library API v2 collection, add a new request named "delete a book."
2. Set the request method to `DELETE`.
3. Set the request URL to `{{baseUrl}}/books/:id`.
4. In the "Params" tab, ensure the `id` path variable is set to `{{id}}`.
5. Save and send the request.

The response should be a 204 No Content, indicating successful deletion.

#### Verifying Deletion

Sending the same request again results in a 404 Not Found error because the book with the specified ID no longer exists.

   ![404 Response](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649797906%2Fdelete+4.1649797906195.png)




---