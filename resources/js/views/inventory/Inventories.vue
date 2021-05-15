<template>
  <div class="row">
    <div class="col">
      <div class="form-group">
        <form @submit.prevent="searchProducts" class="search-input">
          <input type="text" v-model="key" class="form-control" placeholder="BUSCADOR" required>
        </form>
        <br>
        <button type="button" @click="clearFilters" class="btn btn-info">
                <feather type="x"/>
                Filtros
        </button>
        <!--TODO
        1. Filtros Menor Stock
        2. Filtros por Categoría
        -->
      </div>
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between">
            <h3 class="card-title mb-0">Inventario</h3>
            <div class="btn-toolbar">
              <button type="button" @click="downloadExcel" class="btn btn-info mr-2">
                <feather type="download"/>
                Desc Excel 
              </button>
            </div>
          </div>
        </div>
        <hr>
        <div class="card-body row">

          <div class="col-md-6 col-12 row inventory-card" v-for="item in products" :key='item.id'>
            <div class="col-4">
              <img :src="'/api/products/'+item.image_url" alt="">
            </div>
            <div class="col-6">
              <h4><strong>{{ item.name }}</strong></h4>
              <h5>{{ item.category.name }}</h5>

              <h6>Restante: <strong> {{ item.packages }} paquetes </strong></h6>
            </div>
            <div class="col-2">
              <strong>{{ item.packages }}</strong>
              <br>
              <div class="btn-toolbar">
                    <button type="button" class="btn btn-secondary btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <feather type="more-vertical"/>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                      <router-link :to="{ path: `/inventories/${item.id}/create` }" class="dropdown-item">Ingresar Paketes</router-link>
                      <router-link :to="{ path: `/inventories/${item.id}/details` }" class="dropdown-item">Ver Paketes</router-link>
                      <!-- <button class="dropdown-item" type="button">Another action</button> -->
                      <!-- <button class="dropdown-item" type="button">Retirar</button> -->
                    </div>
              </div>
            </div>
          </div>

        </div>
        <div class="card-footer">
            <caption>
              <page-navigation v-model="page" :pages="pages" :count="count" :items="products.length" @confirm="fetchData"/>
            </caption>
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
    clearFilters() {
      this.deleted = null;
      this.payed = null;
      this.delivered = null;
      this.fetchData();
    },
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

<style scoped>
  img{
    width: 100%;
  }
  .row{
    color: white;
  }
  .inventory-card{
    margin-bottom: 1rem;
    margin-top: 1rem;
  }
  .inventory-card .col-6{
    justify-content: center;
    text-align: center;
  }
</style>