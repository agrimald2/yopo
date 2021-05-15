<template>
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between">
            <h3 class="card-title mb-0">Categorias</h3>
            <div class="btn-toolbar">
              <router-link class="btn btn-info" to="/categories/create">
                <feather type="plus"/>
                Nuevo
              </router-link>
            </div>
          </div>
        </div>
        <hr>
        <div class="card-body row">
            <div class="card card-category  col-xl-3 col-md-4 col-12"  v-for="item in categories" :key='item.id'>
              <img class="card-img-top" :src="'/api/categories/'+item.image_url" alt="Card image cap">
              <div class="card-body">
                <h3 class="card-title">{{ item.name }}</h3>
                <p class="card-text">Opciones</p>
                <router-link :to="{ path: `/categories/${item.id}/edit` }">
                  <a href="#" class="btn btn-primary">Editar</a>
                </router-link>
                <a href="#" @click.prevent="deleteCateory(item.id)" class="btn btn-danger">Eliminar</a>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
  img {
    width: 7vw;
    height: 15vh;
    justify-content: center;
    text-align: center;
  }
  p {
    color:whitesmoke
  }
  .card-category{
    align-items: center;
    text-align: center;
    justify-content: center;
  }
</style>
<script>
export default {
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      categories: [],
      page: 1,
      pages: null,
      count: null,
    }
  },
  methods: {
    fetchData() {
      var params = { page: this.page };
      axios.get('categories', { params }).then(res => {
        console.log(res.data);
        this.categories = res.data.categories;
        this.pages = res.data.pages;
        this.count = res.data.count;
      }).catch(res => {
        console.log(res);
      });
    },
    deleteCateory(id) {
      var ok = confirm('Esta seguro de eliminar?...');
      if (ok) {
        axios.delete(`categories/${id}`).then(res => {
          console.log(res);
          this.fetchData();
        });
      }
    },
  }
}
</script>

<style>

</style>