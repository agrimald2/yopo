<template>
  <form @submit.prevent="submit">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">Editar Materia Prima</h3>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="form-group col-md-6">
                <label for="">Nombre</label>
                <input
                  type="text"
                  v-model="rawMaterial.name"
                  class="form-control"
                  placeholder="Nombre"
                  required
                />
              </div>
              <div class="form-group col-md-6">
                <label for="">Unidad</label>
                <select
                  class="custom-select text-uppercase"
                  v-model="rawMaterial.unit_code"
                  required
                >
                  <option
                    v-for="(item, index) in unitCodes"
                    :key="index"
                    :value="item.unitCode"
                  >
                    {{ item.name }}
                  </option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="">Cantidad Actual</label>
                <input type="number" v-model="rawMaterial.weight" class="form-control" min="0" step="any" placeholder="Cantidad" disabled/>
              </div>
              <div class="form-group col-md-6">
                <label for="">Añadir</label>
                <input type="number" v-model="weight_registered" class="form-control" min="0" step="any" placeholder="Cantidad"/>
              </div>
              <div class="form-group col-md-6">
                <label for="">Estado</label>
                <select
                  class="custom-select text-uppercase"
                  v-model="rawMaterial.status"
                  required
                >
                  <option
                    v-for="(item, index) in statuses"
                    :key="index"
                    :value="item.id"
                  >
                    {{ item.name }}
                  </option>
                </select>
              </div>
              <div class="form-group col-12">
                <button type="submit" class="btn btn-info float-right">
                  <feather type="save" />
                  Guardar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      rawMaterial: {},
      weight_initial: 0,
      weight_registered: 15,
      statuses: [
        {id:0, name: 'Pendiente'},
        {id:1, name: 'Finalizado'}
      ]
    }
  },
  methods: {
    fetchData() {
      let rawMaterialId = this.$route.params.rawMaterialId;
      axios.get(`rawMaterial/${rawMaterialId}`).then(res => {
        console.log(res);
        let rawMaterial = res.data.rawMaterial;
        this.rawMaterial = rawMaterial;
        this.weight_registered = res.data.weight_registered;
    });
    },
    submit() {
      //if (this.rawMaterial.weight < this.weight_registered) {
      //  return this.$snotify.error('La cantidad debe ser mayor a la cantidad de productos procesados');
      //}
      this.rawMaterial.weight = this.rawMaterial.weight + parseInt(this.weight_registered);
      this.rawMaterial.weight_remaining = this.rawMaterial.weight_remaining + parseInt(this.weight_registered);
      axios.put(`rawMaterial/${this.rawMaterial.id}`, { rawMaterial: this.rawMaterial }).then(res => {
      console.log(res.data);
        this.$snotify.success('Se han guardado los cambios');
        this.$router.replace('/rawMaterial');
      }).catch(err => {
        // this.$snotify.error(err.response.message);
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>