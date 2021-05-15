<template>
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between">
            <h3 class="card-title mb-0">Materia Prima</h3>
            <div class="btn-toolbar">
              <router-link class="btn btn-info" to="/rawMaterial/create">
                <feather type="plus"/>
                Nuevo
              </router-link>
            </div>
          </div>
        </div>
        <div class="card-body">
          <table class="table">
            <caption>
              <page-navigation v-model="page" :pages="pages" :count="count" :items="rawMaterial.length" @confirm="fetchData"/>
            </caption>
            <thead>
              <th>#</th>
              <th>Nombre</th>
              <th>Cantidad</th>
              <th>Restante</th>
              <th>Estado</th>
              <th>F. Ingreso</th>
              <th>Opciones</th>
            </thead>
            <tbody>
              <tr v-for="(item, index) in rawMaterial" :key='index'>
                <td>{{ item.id}}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.weight+' '+item.unit_code }}</td>
                <td>{{ item.weight_remaining+' '+item.unit_code }}</td>
                <td>{{ statuses[item.status] }}</td>
                <td>{{ formatDate(item.created_at) }}</td>
                <td>
                  <div class="btn-toolbar">
                    <button type="button" class="btn btn-secondary btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <feather type="more-vertical"/>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                      <router-link :to="{ path: `/rawMaterial/${item.id}/products` }" class="dropdown-item">Detalles</router-link>
                      <div v-if="item.status<2">
                        <router-link :to="{ path: `/rawMaterial/${item.id}/edit` }" class="dropdown-item">Editar</router-link>
                        <a @click="terminar(item.id, index)" href="#" class="dropdown-item">Terminado</a>
                        <a href="#" @click.prevent="deleteRawMaterial(item.id)" class="dropdown-item">Eliminar</a>
                      </div>
                    </div>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      rawMaterial: [],
      page: 1,
      pages: null,
      count: null,
      statuses: ['Pendiente', 'Procesando', 'Finalizado']
    }
  },
  //TODO Al eliminar materia Prima, se deben eliminar los paquetes creados con esta Materia Prima y registrar el usuario que eliminó la materia prima
  methods: {
    deleteRawMaterial(id) {
      var ok = confirm('Esta seguro de eliminar?...');
      if (ok) {
        axios.delete(`rawMaterial/${id}`).then(res => {
          console.log(res);
          this.fetchData();
        });
      }
    },
    fetchData() {
      var params = { page: this.page };
      axios.get('rawMaterial', { params }).then(res => {
        console.log(res.data);
        this.rawMaterial = res.data.rawMaterial;
        this.pages = res.data.pages;
        this.count = res.data.count;
      }).catch(err => {
        console.log(err.response);
      });
    },
    terminar(id, index){
      axios.post('rawMaterial/terminar', { id }).then(res => {
        console.log(res.data);
        this.rawMaterial[index].status = 2
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>