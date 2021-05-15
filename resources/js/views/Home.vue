<template>
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Dashboard
            {{sd_p_data}}
          </h3>
        </div>
        <div class="card-body chart-container">
          <!--<div class="row mb-4">
            <div class="col-6">
              <datepicker v-model="sd" append="F. Incial" @change="fetchData"/>
            </div>
            <div class="col-6">
              <datepicker v-model="ed" append="F. Final" @change="fetchData"/>
            </div>
          </div>-->
          <div class="row">
            <div class="col-12">
              <card type="chart">
                <template slot="header">
                  <div class="row">
                    <div class="col-sm-12">
                      <h5 class="card-category">Ventas Por Mes</h5>
                      <h2 class="card-title">{{sales_data[this.sales_data.length-1]}} ventas este mes // <span style="color:#ffed4a">{{this.payed_data}} Pagadas </span> // <span style="color:red">{{sales_data[this.sales_data.length-1]-this.payed_data}} Sin Pagar</span></h2>
                    </div>
                  </div>
                </template>
                <div class="chart-area">
                  <line-chart
                    style="height: 100%"
                    ref="salesChart"
                    chart-id="sales-chart"
                    :chart-data="salesChart.chartData"
                    :gradient-colors="salesChart.gradientColors"
                    :gradient-stops="salesChart.gradientStops"
                    :extra-options="salesChart.extraOptions"
                  >
                  </line-chart>
                </div>
              </card>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <card type="chart">
                <template slot="header">
                  <div class="row">
                    <div class="col-sm-12">
                      <h5 class="card-category">Ingresos por mes</h5> 
                      <h2 class="card-title" style="color:green">
                        <strong>S/ {{(general_revenue_data.total)}}</strong> Cobrados
                      </h2>  
                      
                      <h4 class="card-title" style="color:red">
                        S/{{(general_revenue_data.total-revenue_data[this.revenue_data.length-1])}} Por Cobrar
                      </h4>
                      <h3 class="card-title"> S/ {{(revenue_data[this.revenue_data.length-1])}} Total 
                        <h6>
                          <strong>S/ {{(revenue_data[this.revenue_data.length-1])-this.delivery_price_data.total}} en Productos</strong> y
                          <strong>S/ {{this.delivery_price_data.total}} en Delivery</strong>
                        </h6>
                      </h3> 
                    </div>
                  </div>
                </template>
                <div class="chart-area">
                  <line-chart
                    style="height: 100%"
                    ref="revenueChart"
                    chart-id="revenue-chart"
                    :chart-data="revenueChart.chartData"
                    :gradient-colors="revenueChart.gradientColors"
                    :gradient-stops="revenueChart.gradientStops"
                    :extra-options="revenueChart.extraOptions"
                  >
                  </line-chart>
                </div>
              </card>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-4">
              <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Ventas semanales</h5>
                  <h3 class="card-title">{{total_week_sales}} ventas esta semana</h3>
                </template>
                <div class="chart-area">
                  <line-chart
                    style="height: 100%"
                    chart-id="week-sales-chart"
                    ref="weekSalesChart"
                    :chart-data="weekSalesChart.chartData"
                    :gradient-colors="weekSalesChart.gradientColors"
                    :gradient-stops="weekSalesChart.gradientStops"
                    :extra-options="weekSalesChart.extraOptions"
                  >
                  </line-chart>
                </div>
              </card>
            </div>
            <div class="col-lg-4">
              <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Distritos</h5>
                  <h3 class="card-title">Compras en el último mes</h3>
                </template>
                <div class="chart-area">
                  <bar-chart
                    style="height: 100%"
                    chart-id="deliveries-chart"
                    ref="deliveriesChart"
                    :chart-data="deliveriesChart.chartData"
                    :gradient-stops="deliveriesChart.gradientStops"
                    :extra-options="deliveriesChart.extraOptions"
                  >
                  </bar-chart>
                </div>
              </card>
            </div>
            <div class="col-lg-4">
              <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Productos</h5>
                  <h3 class="card-title">Más vendidos en el último mes</h3>
                </template>
                <div class="chart-area">
                  <bar-chart
                    style="height: 100%"
                    chart-id="inventory-chart"
                    ref="inventoryChart"
                    :chart-data="inventoryChart.chartData"
                    :gradient-stops="inventoryChart.gradientStops"
                    :extra-options="inventoryChart.extraOptions"
                  >
                  </bar-chart>
                </div>
              </card>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6">
              <div class="row">
                  <card type="chart">
                  <template slot="header">
                    <h5 class="card-category">Pendientes</h5>
                    <h3 class="card-title">Tienes <strong>{{pending_deliveries[1]}}</strong> Entregas Pendientes</h3>
                    <!--<h3 class="card-title">Has completado <strong>{{pending_deliveries[0]}}</strong> Ventas este mes</h3>-->
                  </template>
                  <!--<div class="chart-area">
                    <doughnut-chart style="height: 100%"
                    :chartData="pendingChart.chartData"
                    :options="pendingChart.chartOptions">
                    </doughnut-chart>
                  </div>-->
                  </card>
              </div>

              <div class="row">
                <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Mejores Clientes</h5>
                </template>
                <div class="chart-area"> 
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Cliente</th>
                        <th>Whatsapp</th>
                        <th>Compras</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in customers_data" :key='item.id'>
                        <td>{{ item.id }}</td>
                        <td @click="view_client(item.id)">{{ item.name }}</td>
                        <td @click="send_client(item.mobile)">
                             {{ item.mobile }}
                        </td>
                        <td>{{ item.quantity }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                </card>
              </div>

            </div>
            <div class="col-lg-6">
              <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Productos Bajos en Stock</h5>
                  <h3 class="card-title">Tienes {{stock_data.length}} Productos con Poco Stock</h3>
                </template>
                <div class="chart-area" style="overflow-y: scroll;"> 
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Producto</th>
                        <th>Inventario</th>
                        <th>Unidad</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in stock_data" :key='item.id' @click="view_product(item.id)">
                        <td>{{ item.id }}</td>
                        <td>{{ item.name }}</td>
                        <td>{{ item.quantity }}</td>
                        <td>{{ item.unit_code }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </card>
            </div>
          </div>
          <div class="row">
                <card type="chart">
                <template slot="header">
                  <h5 class="card-category">Vendedores</h5>
                </template>
                <div class="chart-area"> 
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Vendedor</th>
                        <th>Ventas</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in sellers_data" :key='item.id'>
                        <td>{{ item.id }}</td>
                        <td>{{ item.name }}</td>
                        <td>{{ item.quantity }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                </card>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import LineChart from '@/components/Charts/LineChart';
  import BarChart from '@/components/Charts/BarChart';
  import DoughnutChart from '@/components/Charts/DoughnutChart';
  import Card from "@/components/Card.vue";
  import * as chartConfigs from '@/components/Charts/config';
  import moment from 'moment-timezone'
  
export default {
  components: {
    LineChart,
    BarChart,
    Card,
    DoughnutChart
  },
  data() {
      return {
        today_day: moment().format('Do'),
        sd: moment().startOf('day').subtract(1,'years'),
        ed: moment().startOf('day'),
        sales_data:[],
        revenue_data:[],
        week_sales_data:[],
        deliveries_data:[],
        inventory_data:[],
        stock_data:[],
        pending_deliveries:[],
        payed:[],
        custumers:[],
        general_revenue:[],
        delivery_price:[],
        sd_p:[],
        ed_p:[],

        sales_labels: [],
        revenue_labels: [],
        week_sales_labels: [],
        deliveries_labels: [],
        inventory_labels: [],

        salesChart: {
          extraOptions: chartConfigs.lineChartOptions,
          chartData: null,
          gradientStops: [1, 0.4, 0],
        },
        revenueChart: {
          extraOptions: chartConfigs.lineChartOptions,
          chartData: null,
          gradientStops: [1, 0.4, 0],
        },
        weekSalesChart: {
          extraOptions: chartConfigs.lineChartOptions,
          chartData: null,
          gradientStops: [1, 0.4, 0],
        },
        deliveriesChart: {
          extraOptions: chartConfigs.barChartOptions,
          chartData: null,
          gradientColors: chartConfigs.colors.primaryGradient,
          gradientStops: [1, 0.4, 0],
        },
        inventoryChart: {
          extraOptions: chartConfigs.barChartOptions,
          chartData: null,
          gradientColors: chartConfigs.colors.primaryGradient,
          gradientStops: [1, 0.4, 0],
        },
        pendingChart: {
          chartOptions: {},
          chartData: null
        },
      }
    },
    computed: {
      total_sales() {
        return this.sales_data.reduce((a, b) => parseFloat(a) + parseFloat(b), 0);
      },
      total_revenue() {
        return this.revenue_data.reduce((a, b) => parseFloat(a) + parseFloat(b), 0);
      },
      total_week_sales() {
        return this.week_sales_data.reduce((a, b) => parseFloat(a) + parseFloat(b), 0);
      }
    },
    watch:{
      sales_data: function (val) {
        //this.salesChart.chartData.datasets[0].data = val;
        this.salesChart.chartData = {
          labels: this.sales_labels,
          datasets: [{
            fill: true,
            borderColor: chartConfigs.colors.info,
            borderWidth: 2,
            borderDash: [],
            borderDashOffset: 0.0,
            pointBackgroundColor: chartConfigs.colors.info,
            pointBorderColor: 'rgba(255,255,255,0)',
            pointHoverBackgroundColor: chartConfigs.colors.info,
            pointBorderWidth: 20,
            pointHoverRadius: 4,
            pointHoverBorderWidth: 15,
            pointRadius: 4,
            data: val,
          }]
        }
      },
      revenue_data: function (val) {
        this.revenueChart.chartData = {
          labels: this.revenue_labels,
          datasets: [{
            fill: true,
            borderColor: chartConfigs.colors.primary,
            borderWidth: 2,
            borderDash: [],
            borderDashOffset: 0.0,
            pointBackgroundColor: chartConfigs.colors.primary,
            pointBorderColor: 'rgba(255,255,255,0)',
            pointHoverBackgroundColor: chartConfigs.colors.primary,
            pointBorderWidth: 20,
            pointHoverRadius: 4,
            pointHoverBorderWidth: 15,
            pointRadius: 4,
            data: val,
          }]
        }
      },
      week_sales_data: function (val) {
        this.weekSalesChart.chartData = {
          labels: this.week_sales_labels,
          datasets: [{
            fill: true,
            borderColor: chartConfigs.colors.green,
            borderWidth: 2,
            borderDash: [],
            borderDashOffset: 0.0,
            pointBackgroundColor: chartConfigs.colors.green,
            pointBorderColor: 'rgba(255,255,255,0)',
            pointHoverBackgroundColor: chartConfigs.colors.green,
            pointBorderWidth: 20,
            pointHoverRadius: 4,
            pointHoverBorderWidth: 15,
            pointRadius: 4,
            data: val,
          }]
        };
      },
      deliveries_data: function (val) {
        this.deliveriesChart.chartData = {
          labels: this.deliveries_labels,
          datasets: [{
            fill: true,
            borderColor: chartConfigs.colors.orange,
            borderWidth: 2,
            borderDash: [],
            borderDashOffset: 0.0,
            data: val,
          }]
        };
      },
      inventory_data: function (val) {
        this.inventoryChart.chartData = {
          labels: this.inventory_labels,
          datasets: [{
            fill: true,
            borderColor: chartConfigs.colors.teal,
            borderWidth: 2,
            borderDash: [],
            borderDashOffset: 0.0,
            data: val,
          }]
        };
      },
      pending_deliveries: function (val) {
        this.pendingChart.chartData = {
          hoverBackgroundColor: "red",
          hoverBorderWidth: 10,
          labels: ["Entregadas", "Pendientes"],
          datasets: [
            {
              label: "Data One",
              backgroundColor: ["#41B883", "#E46651"],
              data: [val[0], val[1]]
            }
          ]
        }
      }
    },
    methods: {
      fetchData(){
        this.resetCharts();
        var params = { 
          sd: this.sd.format(),
          ed: this.ed.format(),
        };
        axios.get('dashboard',{params}).then(res => {
          console.log('HOLA BOLA');
          console.log(res.data);
          console.log('HOLA BOLA2');
          // labels 
          this.sales_labels = Object.keys(res.data.sales)
          this.revenue_labels = Object.keys(res.data.revenue)
          this.week_sales_labels = Object.keys(res.data.week_sales)
          this.deliveries_labels = Object.keys(res.data.deliveries)
          this.inventory_labels = Object.keys(res.data.inventory)
          // data
          this.sales_data = Object.values(res.data.sales);
          this.revenue_data = Object.values(res.data.revenue)
          this.week_sales_data = Object.values(res.data.week_sales)
          this.deliveries_data = Object.values(res.data.deliveries)
          this.inventory_data = Object.values(res.data.inventory)
          this.pending_deliveries = Object.values(res.data.pending_deliveries)
          this.stock_data = res.data.stock
          this.payed_data = res.data.payed
          this.customers_data = res.data.customers
          this.sellers_data = res.data.sellers
          this.delivery_price_data = res.data.delivery_price
          this.general_revenue_data = res.data.general_revenue

          this.ed_p_data = res.data.ed_p
          this.sd_p_data = res.data.sd_p

          console.log(this.stock_data)
          this.$loading(false);

          if(this.stock_data.length > 0){
            this.$snotify.error('Tienes '+ this.stock_data.length +' productos BAJOS de STOCK');
          }

          if(this.pending_deliveries.length > 0){
            this.$snotify.warning('Tienes '+ this.pending_deliveries[1] +' entregas PENDIENTES');
          }
          
        }).catch(error => {
          console.log(error.response);
        });
      },
      resetCharts(){
        this.salesChart.chartData = null;
        this.revenueChart.chartData = null;
        this.weekSalesChart.chartData = null;
        this.deliveriesChart.chartData = null;
        this.inventoryChart.chartData = null;
      },
      view_product(id){
        this.$router.replace(`/inventories/${id}/details`)
      },
      view_client(id){
        this.$router.replace(`/customers/${id}/details`)
      },
      send_client(id){
        window.location.href = `https://wa.me/51${id}`
      }
    },
    mounted() {
      this.$loading(true);
      this.fetchData();
    },
  };
</script>

<style>
.table-hover tbody tr:hover{
  cursor: pointer;
  background-color: rgba(255,255,255,.075);
  color: #fff;
}
</style>