---
title: "Making a GET Request"
description: Making a GET Request.
weight: 4
draft: false
showDate: false
---
## Making a GET Request

A GET request retrieves data from an API endpoint. It's one of the most common HTTP methods. This section describes how to make a GET request using Postman.

### Sending a GET Request

1. Inside the collection, click "+ Add a request".
   ![Add a request](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649281938%2Fadd+request.1649281938816.png)
2. Name the request "get books".
3. Set the request method to `GET`.
4. Set the request URL to `https://library-api.postmanlabs.com/books`.
5. Click "Save" (Ctrl+S or Cmd+S).
   ![Save](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649282885%2Fget+books.1649282885313.png)
6. Click "Send."

### Viewing the Response

The response appears in the lower pane. It should be a JSON array of book objects. The specific books may vary as the database is live and updated by other users.

![Viewing the response](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F26fp2261340y1ukokimvca8su%2Fpublic%2F1649283511%2Fget+books+response.1649283511929.png)


---