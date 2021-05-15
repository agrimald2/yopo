import { Doughnut, mixins } from 'vue-chartjs';

export default {
  extends: Doughnut,
  mixins: [mixins.reactiveProp],
  props: ["options"],
  mounted() {
    // this.chartData is created in the mixin.
    // If you want to pass options please create a local options object
      this.$watch('chartData', (newVal, oldVal) => {
        if (!oldVal) {
          this.renderChart(this.chartData, {
            borderWidth: "10px",
            hoverBackgroundColor: "red",
            hoverBorderWidth: "10px",
            maintainAspectRatio : false,
            responsive: true
          });
        }
      }, { immediate: true });
  }
};
