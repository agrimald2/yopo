<template>
  <div
    class="modal fade"
    id="shoppingModal"
    role="dialog"
  >
    <!-- Make bootstrap modal z-indexes to 1 and 2 -->
    <BootstrapModalFix />
    <!--  -->
    <div class="modal-dialog">
      <form
        @submit.prevent="submit"
        class="modal-content"
      >
        <div class="modal-header">
          <h4 class="modal-title">#COME YOPO</h4>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label for="email">Por favor, ingresa tus datos para continuar</label>
            <select
              class="custom-select op-white"
              v-model="delivery"
              required
            >
              <option
                :value="null"
                disabled="disabled"
                selected="selected"
                class="op-white"
              >DISTRITO DE ENTREGA</option>
              <option
                v-for="item in deliveries"
                :value="item"
                :key="item.id"
                class="op-white"
              >{{ `${item.name} - Costo: S/ ${item.price.toFixed(2)}` }}</option>
            </select>
          </div>
          <div class="form-group">
            <input
              type="tel"
              v-model="customer.document"
              class="form-control"
              placeholder="DNI"
              minlength="8"
              maxlength="8"
              @input="findCustomer"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="text"
              v-model="customer.name"
              class="form-control"
              placeholder="Nombre Completo"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="tel"
              v-model="customer.mobile"
              class="form-control"
              placeholder="Numero de celular"
              minlength="9"
              maxlength="9"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="email"
              v-model="customer.email"
              class="form-control"
              placeholder="Email"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="text"
              v-model="customer.address"
              ref="input"
              class="form-control"
              placeholder="Direccion de entrega"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="text"
              v-model="customer.reference"
              class="form-control"
              placeholder="Referencia de la direccion"
              required
            >
          </div>
          <div class="form-group">
            <input
              type="text"
              v-model="observations"
              class="form-control"
              placeholder="Alguna observación"
            >
          </div>
        </div>
        <div class="modal-footer">
          <button
            type="submit"
            class="btn btn-dark"
            style="color:white"
          >
            Confirmar
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import BootstrapModalFix from "./BootstrapModalFix";

export default {
  mounted() {
    this.fecthData();

    const interval = setInterval(() => {
      if (typeof google == "undefined") return;

      this.googleAutocomplete(
        this.$refs.input,
        "PE",
        [-12.1453041, -77.0561434],
        0.15,
        (address) => {
          this.customer.address = address;
          alert(address);
        }
      );

      clearInterval(interval);
    });
  },
  data() {
    return {
      delivery: null,
      deliveries: [],
      customer: {},
      observations: "",
    };
  },
  computed: {
    ...mapGetters({
      products: "sale/products",
      totalProducts: "sale/totalProducts",
    }),
  },
  methods: {
    fecthData() {
      axios.get("deliveries").then((res) => {
        console.log(res);
        this.deliveries = res.data.deliveries;
      });
    },

    /**
     * Google maps integration
     */
    googleAutocomplete(input, country, coords, radius = 0.15, callback = null) {
      const center = { lat: coords[0], lng: coords[1] };

      // Create a bounding box with sides 0.1 = ~10km away from the center point
      const defaultBounds = {
        north: center.lat + radius,
        south: center.lat - radius,
        east: center.lng + radius,
        west: center.lng - radius,
      };

      const options = {
        bounds: defaultBounds,
        componentRestrictions: { country },
        fields: ["address_components", "geometry", "icon", "name"],
        strictBounds: false,
        types: ["address"],
      };
      const autocomplete = new google.maps.places.Autocomplete(input, options);
      if (callback) {
        autocomplete.addListener("place_changed", () => callback(input.value));
      }
    },
    /** GMAPS END */

    findCustomer() {
      if (this.customer.document.length == 8) {
        var params = {
          dni: this.customer.document,
        };
        axios
          .get("customers/byDni", { params })
          .then((res) => {
            console.log(res);
            this.customer = res.data.customer;
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
    },

    submit() {
      $(".modal").modal("hide");
      this.$loading(true);
      axios
        .post("customers", { customer: this.customer })
        .then((res) => {
          console.log(res);
          var customer = res.data.customer;
          var sale = {};
          (sale.customer_id = customer.id),
            (sale.delivery_id = this.delivery.id);
          sale.delivery_price = this.delivery.price;
          sale.email = customer.email;
          // this.$loading(false);
          //this.$emit('confirm', sale);
          let inventories = [];
          this.products.forEach((item) => {
            inventories.push(
              ...this.checkInventory(item).map((x) => ({
                ...x,
                options: item.options,
              }))
            );
          });
          axios
            .post("/sales/shop", {
              inventories,
              sale: sale,
            })
            .then((res) => {
              console.log("axios.post('/sales/shop') =>", res);
              this.loading = 2;
              var id = res.data.sale.id;
              console.log(res.data.sale.id);
              window.location.href =
                "https://api.whatsapp.com/send?phone=51924649794&text=Hola!%20Le%20envío%20los%20datos%20de%20mi%20pedido%3A%20%0Ahttp%3A%2F%2Fyopo.pe%2F" +
                id +
                "%2FcheckoutDetails%0AQueda%20a%20la%20espera.";
            })
            .catch((error) => {
              this.loading = false;
              this.loading = 3;
              setTimeout(() => {
                this.loading = null;
                this.$emit("error", error.response);
              }, 3000);
              console.log(error.response);
            });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
};
</script>

<style scoped>
select {
  border: 1px solid black;
  background-color: black;
}
::placeholder {
  color: #fff;
}

input {
  border: 1px solid black;
  background-color: black;
}
select {
  border: 1px solid black;
}
.modal-header {
  background-color: black;
  color: #ddc237;
  font-family: "EATHOMASANS";
}
.modal-footer {
  background-color: black;
  font-family: "EATHOMASANS";
}
.modal-body {
  background-color: #ddc237;
}
button {
  background-color: #ddc237;
  color: black !important;
}
.op-white {
  color: white;
}
</style>
