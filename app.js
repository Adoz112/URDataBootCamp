// from data.js
var tableData = data;
var inputText = d3.select("#datetime")
var button = d3.select("filter-btn")

tbody = d3.select("tbody")

function displayData(data){ 
    tbody.text("")
    data.forEach(function(ufosight){
    trow = tbody.append("tr")
    Object.entries(ufosight).forEach(function([key, value]){
        tdate = trow.append("td").text(value)	
    })
})}

displayData(tableData)

function changeHandler(){
    d3.event.preventDefault();
    console.log(inputText.property("value"));
    var new_table = tableData.filter(ufosight => ufosight.datetime===inputText.property("value"))
    displayData(new_table)
}
inputText.on("change", changeHandler)
button.on("click", changeHandler)


