<template>
  <form @submit.prevent="submit" class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Editar Categoria</h3>
        </div>
        <div class="card-body">
          <div class="row form-group">
            <div class="col">
              <label for="">Nombre</label>
              <input type="text" v-model="category.name" class="form-control" placeholder="Nombre" required>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <button type="submit" class="btn btn-info float-right">
                <feather type="save"/>
                Guardar
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col">
    <div class="col">
      <div class="card">
        <input id="inputFile" @change="setImage($event.target.files[0])" type="file" hidden>
        <div class="card-header">
          <h3>Imagen de Categoría</h3>
        </div>
        <label for="inputFile" class="card-body text-white text-center border" style="cursor:pointer">
          <feather class="feather-xxl" type="image" v-if='!src'/>
          <img id="priviewImage" class="img-fluid" :src="src" alt="imagen" v-else>
        </label>
      </div>
    </div>
    </div>
  </form>
</template>

<script>
export default {
  mounted() {
    this.priviewImage = this.$el.querySelector('#priviewImage');
    this.fetchData();
  },
  data() {
    return {
      priviewImage: {},
      category: {},
      srcTmp: null,
      file: null,
    }
  },
  computed: {
    src() {
      if (this.category.image_url && !this.srcTmp) {
        return `/api/categories/${this.category.image_url}`;
      } else if (this.srcTmp) {
        return this.srcTmp;
      } else {
        return null;
      }
    }
  },
  methods: {
      setImage(file) {
      this.file = file;
      console.log(file);
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        // console.log(reader.result);
        this.srcTmp = reader.result;
        // this.priviewImage.src = reader.result;
      };
    },
    fetchData() {
      var categoryId = this.$route.params.categoryId;
      axios.get(`categories/${categoryId}`).then(res => {
        console.log(res);
        this.category = res.data.category;
      });
    },
    async submit() {
      // if (!this.file) {
      //   return this.$snotify.error('Es necesario una imagen');
      // }
      var formData = new FormData();
      if (this.file) {
        formData.append('image', this.file);
        formData.append('image_url', this.category.image_url);
        var config = {
            headers: {
                'content-type': 'multipart/form-data'
            }
        }
        try {
          var path = await axios.post('categories/image', formData, config).then(res => res.data);
        } catch (error) {
          console.log(error.response);        
        }
        this.category.image_url = path;
      }
      axios.put(`categories/${this.category.id}`, { category: this.category }).then(res => {
        console.log(res.data);
        this.$snotify.success('Se han guardado los cambios');
        // this.$router.replace('/categories')
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>