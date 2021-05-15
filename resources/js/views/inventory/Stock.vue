<template>
  <div class="row">
    <div class="col">
      <div class="form-group">
        <form @submit.prevent="searchProducts" class="search-input">
          <input type="text" v-model="key" class="form-control" placeholder="BUSCADOR" required>
        </form>
      </div>
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between">
            <h3 class="card-title mb-0">Stock</h3>
          </div>
        </div>
        <div class="card-body">
          <table class="table">
            <caption>
              <page-navigation v-model="page" :pages="pages" :count="count" :items="products.length" @confirm="fetchData"/>
            </caption>
            <thead>
              <th>Nombre</th>
              <th>Paquetes</th>
              <th>T. Kilos</th>
            </thead>
            <tbody>
              <tr v-for="item in products" :key='item.id'>
                <td>{{ item.name }} {{ item.sub_category.name }} {{ item.category.name }}</td>
                <td>{{ item.packages }} Pak</td>
                <td>{{ item.weights.toFixed(3) }} Kg</td>
                <!-- <td>{{ item.category }}</td>
                <td>{{ item.sub_category }}</td>
                <td>{{ item.sale_price }}</td> -->
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { excelUtils } from '@/mixins'

export default {
  mixins: [excelUtils],
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      products: [],
      page: 1,
      pages: null,
      count: null,
      key: null,
    }
  },
  methods: {
    fetchData() {
      var params = { page: this.page };
      axios.get('products/withInventory', { params }).then(res => {
        console.log(res);
        this.products = res.data.products;
        this.pages = res.data.pages;
        this.count = res.data.count;
      }).catch(err => {
        console.log(err.response);
      });
    },
    searchProducts() {
      axios.get(`products/${this.key}/search`).then(res => {
        console.log(res);
        this.products = res.data.products;
      }).catch(err => {
        console.log(err.response);
        this.$snotify.error(err.response.data);
      });
      this.key = '';
    },
    downloadExcel() {
      axios.get('products/all').then(res => {
        var wscols = [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20];
        var body = [];
        let products = res.data.products;
        body.push([
          'PRODUCTO',
          'PAQUETES',
          'T. DE KILOS',
        ]);
        products.forEach(item => {
          body.push([
            item.name,
            item.packages,
            item.weights,
          ]);
        });
        var name = `Inventario`;
        this.getExcel(body, name, [], wscols);
      });
    },
  }
}
</script>

<style>

</style>