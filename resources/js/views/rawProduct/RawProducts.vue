<template>
  <div class="row">
    <div class="col-md-8">
      <inventory :raw_material_id="rawMaterialId" :finished="rawMaterial_finish"/>
    </div>
    <div class="col-md-4">
      <div class="card">
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
  </div>
</template>

<script>
import inventory from './Inventories';

export default {
  components:{
    inventory
  },
  mounted() {
    this.rawMaterialId = this.$route.params.rawMaterialId;
    this.fetchData();
  },
  data() {
    return {
      rawMaterial: [],
      rawMaterialId: null,
      rawMaterial_finish: false,
      statuses: ['Pendiente', 'Procesando', 'Finalizado']
    }
  },
  methods: {
    fetchData() {
      axios.get(`rawMaterial/${this.rawMaterialId}`).then(res => {
        console.log(res.data);
        this.rawMaterial = res.data.rawMaterial;
        this.rawMaterial_finish = (this.rawMaterial.status == 2);
        console.log(this.rawMaterial_finish)
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>