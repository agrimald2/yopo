export const colors = {
  default: "#344675",
  primary: "#42b883",
  info: "#1d8cf8",
  danger: "#fd5d93",
  teal: "#00d6b4",
  green: '#B5F44A',
  yellow: '#FFD400',
  orange: '#FF9000',
  pink: '#F51AA4',
  primaryGradient: ['rgba(76, 211, 150, 0.1)', 'rgba(53, 183, 125, 0)', 'rgba(119,52,169,0)'],
};
export const basicOptions = {
  maintainAspectRatio: false,
  legend: {
    display: false
  },
  responsive: true,
};

export let lineChartOptions = {
  ...basicOptions,
  tooltips: {
    backgroundColor: '#f5f5f5',
    titleFontColor: '#333',
    bodyFontColor: '#666',
    bodySpacing: 4,
    xPadding: 12,
    mode: "nearest",
    intersect: 0,
    position: "nearest"
  },
  scales: {
    yAxes: [{
      barPercentage: 1.6,
      gridLines: {
        drawBorder: false,
        color: 'rgba(29,140,248,0.0)',
        zeroLineColor: "transparent",
      },
      ticks: {
        suggestedMin: 0,
        padding: 20,
        fontColor: "#9e9e9e"
      }
    }],
    xAxes: [{
      barPercentage: 1.6,
      gridLines: {
        drawBorder: false,
        color: 'rgba(0,242,195,0.1)',
        zeroLineColor: "transparent",
      },
      ticks: {
        padding: 20,
        fontColor: "#9e9e9e"
      }
    }]
  }
}

export let barChartOptions = {
  ...basicOptions,
  tooltips: {
    backgroundColor: '#f5f5f5',
    titleFontColor: '#333',
    bodyFontColor: '#666',
    bodySpacing: 4,
    xPadding: 12,
    mode: "nearest",
    intersect: 0,
    position: "nearest"
  },
  scales: {
    yAxes: [{
      gridLines: {
        drawBorder: false,
        color: 'rgba(29,140,248,0.1)',
        zeroLineColor: "transparent",
      },
      ticks: {
        suggestedMin: 0,
        padding: 20,
        fontColor: "#9e9e9e"
      }
    }],
    xAxes: [{
      gridLines: {
        drawBorder: false,
        color: 'rgba(29,140,248,0.1)',
        zeroLineColor: "transparent",
      },
      ticks: {
        padding: 20,
        fontColor: "#9e9e9e"
      }
    }]
  }
}
