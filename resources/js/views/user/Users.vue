<template>
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-header">
          <div class="d-flex justify-content-between">
            <h3 class="card-title mb-0">Usuarios</h3>
            <div class="btn-toolbar">
              <router-link class="btn btn-info" to="/users/create">
                <feather type="plus"/>
                Nuevo
              </router-link>
            </div>
          </div>
        </div>
        <div class="card-body">
          <table class="table">
            <caption>
              <page-navigation v-model="page" :pages="pages" :count="count" :items="users.length" @confirm="fetchData"/>
            </caption>
            <thead>
              <th>Nombre</th>
              <th>Email</th>
              <th>Opciones</th>
            </thead>
            <tbody>
              <tr v-for="item in users" :key='item.id'>
                <td>{{ item.name }}</td>
                <td>{{ item.email }}</td>
                <td>
                  <div class="btn-toolbar">
                    <button type="button" class="btn btn-secondary btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <feather type="more-vertical"/>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                      <router-link :to="{ path: `/users/${item.id}/edit` }" class="dropdown-item">Editar</router-link>
                      <router-link :to="{ path: `/users/${item.id}/credentials` }" class="dropdown-item">Permisos</router-link>
                      <a href="#" @click.prevent="deleteUser(item.id)" class="dropdown-item">Eliminar</a>
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
      users: [],
      page: 1,
      pages: null,
      count: null,
    }
  },
  methods: {
    deleteUser(id) {
      var ok = confirm('Esta seguro de eliminar?...');
      if (ok) {
        axios.delete(`users/${id}`).then(res => {
          console.log(res);
          this.fetchData();
        });
      }
    },

    fetchData() {
      var params = { page: this.page };
      axios.get('users', { params }).then(res => {
        console.log(res.data);
        this.users = res.data.users;
        this.pages = res.data.pages;
        this.count = res.data.count;
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>