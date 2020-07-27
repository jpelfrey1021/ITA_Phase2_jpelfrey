window.onload = function () {

    var chart = new CanvasJS.Chart("chartContainer", {
        animationEnabled: true,
        exportEnabled: true,
        toolTip: {
            shared: true
        },
        axisX:{
            labelFontSize: 10,
            labelFontColor: "#7D82C3",
            tickThickness: 0,
            lineColor: "#CBC6C6",
            margin: 10
        },
        axisY:{
            tickThickness: 0,
            labelFontSize: 0,
            lineThickness: 0,
            gridColor: "#CBC6C6",
            margin: -20
        },
        legend:{
            cursor:"pointer",
            itemclick: toggleDataSeries,
            fontFamily: "'Poppins', sans-serif",
            fontColor: "#8D8D8D",
            verticalAlign: "top",
            horizontalAlign: "left",
            fontSize: 10,
            fontWeight: 'light',
            itemWidth: 75

        },
        data: [{        
            type: "spline",  
            name: "This Week",        
            showInLegend: true,
            markerType: "none",
            color: "#373FA3",
            lineThickness: 5,
            dataPoints: [
                { label: "Mon" , y: 2.39}, 
                { label:"Tues", y: 10.25 },     
                { label: "Wed", y: 5.34 },     
                { label: "Thu", y: 7.99 },     
                { label: "Fri", y: 15.55, markerType: "circle", markerColor: "#373FA3", markerSize: 12 }
            ]
        }, 
        {        
            type: "spline",
            name: "Last Week",        
            showInLegend: true,
            markerType: "none",
            color: "#D0D2EA",
            lineThickness: 5,
            dataPoints: [
                { label: "Mon" , y: 10.16 },     
                { label:"Tues", y: 13.59 },     
                { label: "Wed", y: 0 },     
                { label: "Thu", y: 14.67 },     
                { label: "Fri", y: 5.05 },
                { label: "Sat", y: 7.76 },
                { label: "Sun", y: 8.97 }
            ]
        }]
    });
    
    chart.render();
    
    function toggleDataSeries(e) {
        if(typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
            e.dataSeries.visible = false;
        }
        else {
            e.dataSeries.visible = true;            
        }
        chart.render();
    }
    
}