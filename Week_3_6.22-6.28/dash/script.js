window.onload = function() {
    var chart = new CanvasJS.Chart("agent-profitability", {
        animationEnabled: true,
        axisX:{
            labelFormatter: function ( e ) {
                return '';  
            },
            tickLength: 0,
            lineThickness: 0,
            
        },
        axisY:{
            labelFormatter: function ( e ) {
                return '';  
            },
            tickLength: 0, 
            lineThickness: 0,
            gridThickness: 1,
            gridColor: "#8087A3",
            gridDashType: "longDash",
            interval: 20000,
        },
        data: [{
            name: "Active",
            type: "area",
            fillOpacity: .1,
            color: "#344CE9",
            markerSize: 0,
            dataPoints: [
                { x: 0, y: 35000 },
                { x: 1, y: 32500 },
                { x: 3, y: 40000 },
                { x: 4, y: 45000 },
                { x: 5, y: 50000 },
                { x: 6, y: 45000 },
                { x: 7, y: 57500 },
                { x: 8, y: 60000 },
                { x: 9, y: 65000 },
                { x: 10, y: 70000 },
                { x: 12, y: 60000 },
                { x: 13, y: 62500 },
                { x: 14, y: 62000 },
                { x: 15, y: 63000 },
                { x: 17, y: 75000 },
                { x: 18, y: 75000 },
                { x: 19, y: 77500 },
                { x: 20, y: 70000 },
                { x: 21, y: 75000 },
                { x: 22, y: 76000 },
                { x: 23, y: 74000 }
            ]
        },
        {
            name: "Inactive",
            type: "area",
            fillOpacity: .1,
            color: "#FF6D02",
            dataPoints: [
                { x: 0, y: 17500 },
                { x: 1, y: 21000 },
                { x: 3, y: 22000 },
                { x: 4, y: 17000 },
                { x: 5, y: 17100 },
                { x: 6, y: 18000 },
                { x: 7, y: 17500 },
                { x: 8, y: 20000 },
                { x: 9, y: 17000 },
                { x: 10, y: 20000 },
                { x: 11, y: 25000 },
                { x: 12, y: 25000 },
                { x: 13, y: 30000 },
                { x: 14, y: 35000 },
                { x: 15, y: 30000 },
                { x: 16, y: 29000 },
                { x: 17, y: 40000 },
                { x: 18, y: 40000 },
                { x: 19, y: 50000 },
                { x: 20, y: 58000 },
                { x: 21, y: 50000 },
                { x: 22, y: 50000 },
                { x: 23, y: 61000 }
            ]
        }]
    });
    chart.render(); 
}