window.onload = function () {

    var chart = new CanvasJS.Chart("transaction__chart", {
        animationEnabled: true,
        backgroundColor: '#4953CF',
        toolTip: {
            fontColor: "#FFFFFF",
            cornerRadius: 6,
            backgroundColor: "#373FA3",
            content: "${y}"
        },
        axisY: {
            tickThickness: 0,
            gridThickness: 0,
            labelFontSize: 0,
            lineThickness: 0,
            maximum: 5
        },
        axisX: {
            tickThickness: 0,
            lineThickness: 0,
            labelFontColor: "#FFFFFF",
            fontFamily: "'Poppins', sans-serif"
        },
        dataPointWidth: 10,
        data: [{        
            type: "column",
            color: '#ffffff',
            dataPoints: [      
                { y: 1.59, label: "Mon" },
                { y: 4.26,  label: "Tue" },
                { y: 3.25,  label: "Wed" },
                { y: 0,  label: "Thu" },
                { y: 0,  label: "Fri" },
                { y: 0, label: "Sat" },
                { y: 0,  label: "Sun" }
            ]
        }]
    });
    chart.render();
    
}