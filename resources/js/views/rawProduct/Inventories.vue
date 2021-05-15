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
            <h3 class="card-title mb-0">Inventario</h3>
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
              <th>Opciones</th>
            </thead>
            <tbody>
              <tr v-for="item in products" :key='item.id'>
                <td>{{ item.name }} {{ item.sub_category.name }} {{ item.category.name }}</td>
                <td>{{ item.packages }} Pak</td>
                <td>{{ item.weights.toFixed(3) }} Kg</td>
                <td>
                  <div class="btn-toolbar">
                    <button type="button" class="btn btn-secondary btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <feather type="more-vertical"/>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                      <div v-if="!finished">
                        <router-link :to="{ path: `/rawMaterial/${raw_material_id}/${item.id}/create` }" class="dropdown-item">Ingresar Paketes</router-link>
                      </div>
                      
                      <router-link :to="{ path: `/inventories/${item.id}/details?raw_material=${raw_material_id}` }" class="dropdown-item">Ver Paketes</router-link>
                    </div>
                  </div>
                </td>
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
  props:['raw_material_id','finished'],
  mixins: [excelUtils],
  watch: {
    raw_material_id: function(id){
      this.fetchData(id);
    }
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
    fetchData(id) {
      var params = { page: this.page };
      axios.get(`rawMaterial/${id}/inventory`, { params }).then(res => {
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
    }
  }
}
</script>

<style>

</style>