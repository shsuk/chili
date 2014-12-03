function drawChart(type, chart_id, chartData){
	$( window  ).resize(function() {
		try {
			var chartId = $(chart_id);
			if(chartId.length<1 || chartId.get(0).clientHeight==0){
				return;
			}
			$.chart_fnc[type](chart_id, chartData);
		} catch (e) {
			// TODO: handle exception
		}
	}).resize();		

}

$.chart_fnc = {
	chart_bar_iy : function(selector, chartData){
		drawBarIY(selector, chartData);
	},
	chart_bar_ixy : function(selector, chartData){
		drawBarIXY(selector, chartData);

	},
	chart_bar_xy : function(selector, chartData){
		drawBarXY(selector, chartData);
	},
	//chart_line_xy : drawLineXY(selector, chartData),
	chart_line_ixy : function(selector, chartData){
		drawLineIXY(selector, chartData);
	},		
	chart_pie_iy : function(selector, chartData){
		drawPie(selector, chartData);
	},
	chart_bubble : function(selector, chartData){
		drawBubble(selector, chartData);
	}
};

function drawBarIY(selector, chartData){
	var horizontal = false;

	Flotr.draw($(selector).get(0), chartData.data, {
		bars : {
			show : true,
			horizontal : horizontal,
			//shadowSize : 0,
			barWidth : 1
		},
		legend: {
            position: 'ne',
            // Position the legend 'south-east'.
            //labelFormatter: labelFn,
            // Format the labels.
            backgroundColor: '#D2E8FF' // A light blue background color.
        },
		xaxis : {
			noTicks: chartData.data.length+2, // Display n ticks.
            tickFormatter: function(n) {
                return '&nbsp;'; //''&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' + Math.ceil(n) + '월';
            },
			showLabels: true
		},
		yaxis : {
			min : 0,
			autoscaleMargin : 1,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		mouse : {
			track : true,
			relative : true,
            position: 'ns',
			trackFormatter: function(data) {
				return data.series.label + ' : ' + Math.ceil(data.y)
			}
		},
        grid: {
            horizontalLines: true,
            verticalLines: false
        }
	});
	
}


function drawBarIXY(selector, chartData){
	var horizontal = false;

	Flotr.draw($(selector).get(0), chartData.data, {
		bars : {
			show : true,
			horizontal : horizontal,
			//shadowSize : 0,
			barWidth : 3600000*20/chartData.itemCount
		},
		xaxis : {
			mode: chartData.type,
            labelsAngle: 45,
			noTicks: 5,
			timeUnit: 'hour',
			tickFormatter: function(n) {
				var date = new Date();
				date.setTime(n);
				return '&nbsp;&nbsp;' + $.datepicker.formatDate(('mm-dd '), date);
            }
		},
		yaxis : {
			min:0,
			autoscaleMargin : 1,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		mouse : {
			track : true,
			relative : true,
            position: 'ns',
			trackFormatter: function(data) {
				var date = new Date();
				date.setTime(data.x);
				return data.series.label + ' : (' + $.datepicker.formatDate(('yy-mm-dd '), date) + ', ' + Math.ceil(data.y) + ')'
			}
		},
        grid: {
            horizontalLines: true,
            verticalLines: true
        }
	});
	
}

function drawBarXY(selector, chartData){
	var horizontal = false;

	Flotr.draw($(selector).get(0), chartData.data, {
		bars : {
			show : true,
			horizontal : horizontal,
			//shadowSize : 0,
			barWidth : 3600000*21
		},
		xaxis : {
			mode: chartData.ype,
            labelsAngle: 45,
			noTicks: chartData.data.length+5,
			tickFormatter: function(n) {
				var date = new Date();
				date.setTime(n);
				return $.datepicker.formatDate(('yy-mm-dd '), date);
            }
		},
		yaxis : {
			autoscaleMargin : 1,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		mouse : {
			track : true,
			relative : true,
            position: 'ns',
			trackFormatter: function(data) {
				var date = new Date();
				date.setTime(data.x);
				return $.datepicker.formatDate(('yy-mm-dd '), date) + ' : ' + Math.ceil(data.y)
			}
		},
        grid: {
            horizontalLines: true,
            verticalLines: true
        }
	});																			
}

function drawLineIXY(selector, chartData){
	Flotr.draw($(selector).get(0), chartData.data, {
		xaxis : {
			mode: chartData.type,
            labelsAngle: 45,
			noTicks: 5,
			tickFormatter: function(n) {
				var date = new Date();
				date.setTime(n);
				return '&nbsp;&nbsp;' + $.datepicker.formatDate(('mm-dd '), date);
            }
		},
		yaxis : {
			min:0,
			autoscaleMargin : 1,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		mouse : {
			track : true,
			relative : true,
            position: 'ns',
			trackFormatter: function(data) {
				var date = new Date();
				date.setTime(data.x);
				return data.series.label + ' : (' + $.datepicker.formatDate(('yy-mm-dd '), date) + ', ' + Math.ceil(data.y) + ')'
			}
		},
        grid: {
            horizontalLines: true,
            verticalLines: true
        }
	});
}

function drawPie(selector, chartData){
	
	Flotr.draw($(selector).get(0), chartData.data, {
		HtmlText : false,
		grid : {
			verticalLines : false,
			horizontalLines : false
		},
		xaxis : {
			showLabels : false
		},
		yaxis : {
			showLabels : false
		},
		pie : {
			show : true,
			explode : 6
		},
		mouse : {
			track : true,
			trackFormatter: function(data) {
				return data.series.label + ' : ' + Math.ceil(data.y)
			}
		},
		legend : {
			position : 'ne',
			backgroundColor : '#D2E8FF'
		}
	});
}

function drawBubble(selector, chartData){
	Flotr.draw($(selector).get(0), chartData.data, {
		bubbles: {
            show: true,
            baseRadius: 5
        },
		xaxis : {
            min: chartData.minX - chartData.maxZ,
            max: chartData.maxX + chartData.maxZ,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		yaxis : {
            min: chartData.minY - chartData.maxZ,
            max: chartData.maxY + chartData.maxZ,
			autoscaleMargin : 1,
			tickFormatter: function(n) {
                return Math.ceil(n);
            }
		},
		mouse : {
			track : true,
			relative : true,
            position: 'nn',
			trackFormatter: function(data) {
				return data.series.label + ' : (' + Math.ceil(data.x) + ', ' + Math.ceil(data.y) + ', ' + Math.ceil(data.series.data[0][2]) + ')';
			}
		},
        grid: {
            horizontalLines: true,
            verticalLines: true
        }
	});
}



