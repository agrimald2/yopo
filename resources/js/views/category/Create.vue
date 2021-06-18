<template>
  <form @submit.prevent="submit" class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Nueva Categoria</h3>
        </div>
        <div class="card-body">
          <div class="row form-group">
            <div class="col">
              <label for="">Nombre</label>
              <input type="text" v-model="category.name" class="form-control" placeholder="Nombre" required>
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
      <!-- <div class="card">
        <div class="card-header">
          <h3>Imagen del Producto</h3>
        </div>
        <div class="card-body">

        </div>
      </div> -->
    </div>
  </form>
</template>

<script>
import Compressor from 'compressorjs'
export default {
  data() {
    return {
      category: {},
      srcTmp: null,
      file: null
    }
  },
  computed: {
    src() {
      if (this.category.image_url) {
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
      // console.log(file);
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        // console.log(reader.result);
        this.srcTmp = reader.result;
      };
    },
    async submit() {
      if (!this.file) {
        return this.$snotify.error('Es necesario una imagen');
      }
      var image = await new Promise((resolve, reject) => {
        new Compressor(this.file, {
          quality: 0.2,
          success: async (result) => {
            const formData = new FormData();
            resolve(result);
            // formData.append('file', result, result.name);
            // await this.$http.post('uploadsPhotos', formData).then(res => {
            //   var file = res.body.file;
            //   this.pictures.push(file)
            // });
          }
        });
      });
      var formData = new FormData();
      formData.append('image', image);
      var config = {
          headers: {
              'content-type': 'multipart/form-data'
          }
      }
      var path = await axios.post('categories/image', formData, config).then(res => res.data);
      this.category.image_url = path;
      axios.post('categories', { category: this.category }).then(res => {
        console.log(res.data);
        this.$snotify.success('Categoria registrada correctamente');
        this.$router.replace('/categories')
      }).catch(err => {
        console.log(err.response);
      });
    }
  }
}
</script>

<style>

</style>