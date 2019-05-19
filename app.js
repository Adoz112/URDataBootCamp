// @TODO: YOUR CODE HERE!
var svgWidth = 960;
var svgHeight = 500;

var margin = {
  top: 20,
  right: 40,
  bottom: 60,
  left: 100
};

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

// Create an SVG wrapper, append an SVG group that will hold our chart, and shift the latter by left and top margins.
// var svg = d3.select("#scatter")
  // .append("svg")
  // .attr("width", svgWidth)
  // .attr("height", svgHeight);

  var svg = d3.select("#container")
  .append("svg")
  .attr("preserveAspectRatio", "xMinYMin meet")
  .attr("viewBox", "0 0 " + svgWidth + " " + svgHeight)
  .classed("svg-content", true);
  

 var dataGroup = svg.append("g")
  .attr("transform", `translate(${margin.left}, ${margin.top})`);


    d3.csv("/assets/data/data.csv")
      .then(function(data) {
      
 
      data.forEach(function(data) {
      data.income = +data.income;
      data.obesity = +data.obesity;
      });
  
  var xLinearScale = d3.scaleLinear()
      .domain([35000, d3.max(data, d => d.income)])
      .range([0, width]);

  var yLinearScale = d3.scaleLinear()
      .domain([20, d3.max(data, d => d.obesity)])
      .range([height, 0]);

  var bottomAxis = d3.axisBottom(xLinearScale);
  var leftAxis = d3.axisLeft(yLinearScale);

  dataGroup.append("g")
            .attr("transform", `translate(0, ${height})`)
            .call(bottomAxis);  

  dataGroup.append("g")
           .call(leftAxis);       
           
  var circles = dataGroup.selectAll("circle")
               .data(data)
               .enter()
               .append("circle")
               .attr("cx", d => xLinearScale(d.income))
               .attr("cy", d => yLinearScale(d.obesity))
               .attr("r", "15")
               .attr("fill", "lightblue")
               .attr("opacity", ".5");
         
  var toolTip = d3.tip()
               .attr("class", "tooltip")
               .offset([80, -60])
               .html(function(d) {
               return (`${d.abbr}<br>Income: $ ${d.income}<br>Obese: ${d.obesity}%`);
      });
  
    dataGroup.call(toolTip);

    dataGroup.append("text")
              .style("text-anchor", "middle")
              .style("font-size", "12px")
              .selectAll("tspan")
              .data(data)
              .enter()
              .append("tspan")
              .attr("x", function(data) {
               return xLinearScale(data.income);
        })
              .attr("y", function(data) {
              return yLinearScale(data.obesity);
        })
              .text(function(data) {
              return data.abbr
        });

      circles.on("mouseover", function (d) {
          toolTip.show(d, this);
      })
      circles.on("mouseout", function (d, i) {
          toolTip.hide(d);
    });  
      dataGroup.append("text")
                 .attr("transform", "rotate(-90)")
                 .attr("y", 0 - margin.left + 40)
                 .attr("x", 0 - (height / 2))
                 .attr("dy", "1em")
                 .attr("class", "axisText")
                 .text("Obese (%)");
      
      dataGroup.append("text")
                 .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
                 .attr("class", "axisText")
                 .text("Household Income (Median)");

     
      });