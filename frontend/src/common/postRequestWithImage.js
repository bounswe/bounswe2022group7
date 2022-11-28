

const postRequestWithImage = (
  url, // address we are making a request to
  base64String, // base64String is the string of the image
  formatFunction, // a function that receives id of the image and constructs the request body
  navigateToFunction, // a function that constructs a path to navigate to from the response
  token
) => {
  fetch("/api/image", {
    method: "POST",
    body: JSON.stringify({base64String: base64String}),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    },
  })
    .then((response) => response.json())
    .then((data) => {
      const posterId = data.id

      fetch(url, {
        method: "POST",
        body: JSON.stringify(formatFunction(posterId)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      })
        .then((response) => response.json())
        .then((data) => {window.location.href = navigateToFunction(data)})
    }
  )
}

export default postRequestWithImage