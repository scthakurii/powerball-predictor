document.getElementById("predictButton").addEventListener("click", function() {
    fetch("https://your-api-url.com/predict")  // Replace with actual API URL
    .then(response => response.json())
    .then(data => {
        let resultText = `<h3>Your Powerball Numbers:</h3>`;
        data.forEach((set, index) => {
            resultText += `<p><strong>Set ${index + 1}:</strong> White Balls: ${set["White Balls"].join(", ")} | Powerball: ${set["Powerball"]}</p>`;
        });
        document.getElementById("result").innerHTML = resultText;
    })
    .catch(error => {
        console.error("Error fetching prediction:", error);
        document.getElementById("result").innerHTML = "<p style='color:red;'>Failed to get numbers. Try again later.</p>";
    });
});
