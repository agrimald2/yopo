<template>
  <form @submit.prevent="submit">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">Nueva Materia Prima</h3>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="form-group col-12">
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
                <label for="">Cantidad</label>
                <input type="number" v-model="rawMaterial.weight" class="form-control" min="0" step="any" placeholder="Cantidad" required/>
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
  data() {
    return {
      rawMaterial: {}
    };
  },
  methods: {
    submit() {
      // if (this.user.password != this.user.password_confirmation) {
      //   return this.$snotify.error("Las contraseñas no coinciden");
      // }
      this.rawMaterial.weight_remaining = this.rawMaterial.weight;
      axios
        .post("rawMaterial", { rawMaterial: this.rawMaterial })
        .then((res) => {
          console.log(res.data);
          this.$snotify.success("Materia prima registrada correctamente");
          this.$router.replace("/rawMaterial");
        })
        .catch((err) => {
          // this.$snotify.error(err.response.message);
          console.log(err.response);
        });
    },
  },
};
</script>

<style>
</style>