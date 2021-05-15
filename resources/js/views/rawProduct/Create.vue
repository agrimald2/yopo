<template>
  <form @submit.prevent="submit" class="row">
    <div class="col-md-8">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Ingreso de Inventario</h3>
          <h5 class="card-title">Cantidad disponible: {{ weight_remaining+' '+rawMaterial.unit_code }}</h5>
        </div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">
            <button type="button" class="btn btn-info btn-block" @click="addInventory">
              <feather type="plus"/>
              Agregar 
            </button>
          </li>
          <li class="list-group-item d-flex justify-content-between" v-for="(item, index) in inventories" :key="index">
            <div class="input-group mr-2">
              <div class="input-group-prepend">
                <div class="input-group-text">
                  Kilos
                </div>
              </div>
              <input type="number" v-model="item.weight" class="form-control" min="0" step="any" placeholder="Kilos" required>
            </div>
            <div class="input-group mr-2">
              <div class="input-group-prepend">
                <div class="input-group-text">
                  Cantidad
                </div>
              </div>
              <input type="number" v-model="item.quantity" class="form-control" placeholder="Cantidad" min="1" required>
            </div>
            <div class="input-group mr-2">
              <div class="input-group-prepend">
                <div class="input-group-text">
                  Sucursal
                </div>
              </div>
              <select v-model="item.office_id" class="custom-select" required>
                <option v-for="(item, index) in offices" :key="index" :value="item.id">
                  {{ item.name }}
                </option>
              </select>
            </div>
            <button type="button" class="btn btn-secondary" @click="inventories.splice(index, 1)">
              <feather type="trash-2"/>
            </button>
          </li>
          <li class="list-group-item">
            <button type="submit" class="btn btn-info float-right">
              <feather type="save"/>
              Guardar
            </button>
          </li>
        </ul>
      </div>
    </div>
    <div class="col">
      <div class="card">
        <div class="card-header">
          <h3>Datos del Producto</h3>
        </div>
        <ul class="list-group">
          <li class="list-group-item d-flex justify-content-between">
            <span>Nombre:</span>
            <span>{{ product.name }}</span>
          </li>
          <li class="list-group-item d-flex justify-content-between">
            <span>Categoria:</span>
            <span>{{ product.category.name }}</span>
          </li>
          <li class="list-group-item d-flex justify-content-between">
            <span>Sub Categoria:</span>
            <span>{{ product.sub_category.name }}</span>
          </li>
          <li class="list-group-item d-flex justify-content-between">
            <span>Peso Total:</span>
            <span>{{ total_weight }} Kg</span>
          </li>
        </ul>
        <!-- <div class="card-body">
          
        </div> -->
      </div>
      <div class="card mt-4">
        <div class="card-header">
          <h3 class="card-title mb-0">Detalles Materia Prima</h3>
        </div>
        <div class="card-body">
          <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between">
              <span>Nombre:</span>
              <span>{{ rawMaterial.name }}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Cantidad:</span>
              <span>{{ rawMaterial.weight+' '+rawMaterial.unit_code }}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Restante:</span>
              <span>{{ rawMaterial.weight_remaining+' '+rawMaterial.unit_code }}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Estado:</span>
              <span>{{ statuses[rawMaterial.status] }}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Fecha de ingreso:</span>
              <span>{{ formatDate(rawMaterial.created_at) }}</span>
            </li>
          </ul>
        </div>
      </div>
    </div>

  </form>
</template>

<script>
export default {
  mounted() {
    this.inventories.push(Object.assign({}, this.inventory));
    this.fetchData();
  },
  data() {
    return {
      product: {
        category: {},
        sub_category: {},
      },
      inventory: {
        weight: null,
        quantity: 1
      },
      inventories: [],
      rawMaterial: {},
      offices:[],
      statuses: ['Pendiente', 'Procesando', 'Finalizado']
    }
  },
  computed:{
    total_weight: function(){
      return this.inventories.map(e => e.weight * e.quantity).reduce((a, b) => a + b, 0)
    },
    weight_remaining: function(){
      return this.rawMaterial.weight_remaining - this.total_weight;
    }
  },
  methods: {
    addInventory() {
      console.log('chulapi');
      this.inventories.push(Object.assign({}, this.inventory));
    },
    fetchData() {
      var productId = this.$route.params.productId;
      axios.get(`products/${productId}`).then(res => {
        console.log(res);
        this.product = res.data.product;
      }).catch(err => {
        console.log(err.response);
      });
      var rawMaterialId = this.$route.params.rawMaterialId;
      axios.get(`rawMaterial/${rawMaterialId}`).then(res => {
        console.log(res);
        this.rawMaterial = res.data.rawMaterial;
      }).catch(err => {
        console.log(err.response);
      });
      axios.get(`offices`).then(res => {
        console.log(res);
        this.offices = res.data.offices;
      }).catch(err => {
        console.log(err.response);
      });
    },
    submit() {
      if (!this.inventories.length) {
        return this.$snotify.error('Es necesario al menos 1 ingreso');
      }
      //if (this.total_weight > this.rawMaterial.weight_remaining) {
      //  return this.$snotify.error('La cantidad es mayor a a la disponible');
      //}
      this.inventories.forEach(item => {
        item.product_id = this.product.id;
        item.raw_material_id = this.$route.params.rawMaterialId;
      });
      axios.post('inventories', { inventories: this.inventories }).then(res => {
        console.log(res.data);
        this.$snotify.success('Inventario registrado correctamente');
        this.$router.replace(`/rawMaterial/${this.rawMaterial.id}/products`)
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>