<template>
  <v-container fluid grid-list-md class="contenido">
    <v-layout wrap>
      <!-- RERPORTE INGRESOS APROBADA-->
      <v-flex xs12 sm6 md3>
        <v-hover>
          <v-card @click="dialogo_ingreso()" slot-scope="{ hover }"  
                :class="`elevation-${hover ? 12 : 2}`" >
            <div class="imagen" @click="dialogo_ingreso()">
              <img 
                src="data:image/png;base64,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"
              />
            </div>

            <v-card-title primary-title>
              <div class="texto">
                <h3 class="headline mb-0">Ingresos</h3>
                <div>
                  Se muestra el listado de ingresos aprobadas en un rango de
                  fecha
                </div>
              </div>
            </v-card-title>

            <v-card-actions>
              <v-dialog
                v-model="ingre"
                scrollable
                max-width="800px"
                min-width="800px"
                max-height="500px"
                min-height="500px"
              >
                <v-card>
                  <v-card-text>
                    <v-btn @click="crearPDFAutotableCotizacionAprobada()"
                      ><v-icon>print</v-icon>
                    </v-btn>
                    <v-layout>
                      <v-text-field
                        type="date"
                        label="Desde"
                        v-model="desdeCA"
                      ></v-text-field>
                      <v-text-field
                        type="date"
                        label="Hasta"
                        v-model="hastaCA"
                      ></v-text-field>
                      <v-btn text @click="ReporteCotizacion()">Generar</v-btn>
                    </v-layout>
                    <div id="principal" class="RecuperacionQuincena">
                      <header class="cabecera">
                        <h1>INGRESOS APROBADA</h1>
                        <h2>FARMACIA ESCORCIA</h2>
                        <h3>{{ cabeceraReport.numRuc }}</h3>
                        <div class="caja">
                          <h3>
                            Hasta: <strong>{{ hastaCA }}</strong>
                          </h3>
                          <h3>
                            Desde: <strong>{{ desdeCA }}</strong>
                          </h3>
                        </div>
                      </header>
                      <section>
                        <table class="tabla">
                          <tr>
                            <th>Id ingreso</th>
                            <th>Código articulo</th>
                            <th>Articulo</th>
                            <th>Proveedor</th>
                            <th>Cantidad</th>
                            <th>Valor</th>
                            <th>Fecha</th>
                          </tr>

                          <tr v-for="x in reporteCotizacion" :key="x.id">
                            <th v-text="x.id_ingreso"></th>
                            <th v-text="x.codigo_arti"></th>
                            <th v-text="x.nom_arti"></th>
                            <th v-text="x.proveedor"></th>
                            <th v-text="x.cantidad"></th>  
                            <th v-text="x.valor"></th>
                            <th v-text="x.fecha"></th>
                          </tr>
                        </table>

                        <v-btn
                          @click="ingre = false"
                          color="blue darken-1"
                          text
                          class="btn-color"
                          >Cancelar</v-btn
                        >
                      </section>
                    </div>
                  </v-card-text>
                </v-card>
              </v-dialog>
            </v-card-actions>
          </v-card>
        </v-hover>
      </v-flex>

    </v-layout>

    <!-- PANTALLA DE CARGA-->
    <PantallaCarga :activo="carga" @escucharResultPantalla="resultPantalla()"> </PantallaCarga>
        <!-- DIALOGO DE ERROR-->
    <Mensaje :activo="activarError" :msj="msjError" :tipo="tipoMsj" @escucharResultMsj="resultMsj()"> </Mensaje>
    <!--- CIERRE DE SECION --->
    <Secion :activo="login_" @escucharResult="resultHijo()" ></Secion>
  </v-container>
</template>

<script>
import axios from "axios";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import Secion from '@/components/Secion';
import Mensaje from '@/components/Mensaje';
import PantallaCarga from '@/components/PantallaCarga';

export default {
  data() {
    return {
      carga :false,
      cabeceraReport: [],
      //seguimiento
      reportSeguimiento: 0,
      usuarios: [{ text: "Todos", value: "0" }],
      filtro: "",
      seguimiento: [],
      desdeS:'',
      hastaS:'',
      //Cotizacion
      cotizacionAprobada: 0,
      desdeCA: "",
      hastaCA: "",
      reporteCotizacion: [],
      //Articulo
      articuloVencido:0,
      articulos:[],
      //Documento Cobro
      cobro:0,
      cobros:[],
      tipoEstado:[
        {text:"Pendiente",value:1},
        {text:"Anulada",value:2},
        {text:"Pagado",value:3},
       /* {text:"Todo",value:4},*/
      ],
      cDesde:'',
      cHasta:'',
      selectEstado:'',
      //secion
      login_:false,
      tipoMsj:'',
      msjError:'',
      activarError:false,
      ingre:false,

    
    };
  },
  components:{
      Secion,
      Mensaje,
      PantallaCarga
    },
  created() {
  },
  methods: {
      //SECION
        resultHijo(){
            this.login_ = false;
        },
        resultMsj(){
            this.activarError = false; 
        },  
        resultPantalla(){
            this.carga = false;
        },
        activarErrores(tipo,err,color){
            if(tipo == 1){
                this.login_ =true;
            }else{
                this.activarError=true;
                this.msjError = err;
                this.tipoMsj = color;
                setTimeout(this.resultMsj,2000);
            }
        },
        //FIN - SECION

        dialogo_ingreso(){
            alert('hola');
            this.ingre = true;
        },

        ReporteCotizacion() {
            if (!this.desdeCA || !this.hastaCA || this.desdeCA > this.hastaCA) {
            this.activarErrores(2,"Verificar campos, no puede estar vacio y desde no puede ser mayor a hasta.","red"); //error
            } else {
            this.carga = true; //pantalla de carga 
            let me = this;
            let header = { Authorization: "Bearer " + this.$store.state.token };
            let configuracion = { headers: header };
            axios
                .get(
                "api/ingresos/IngresosXFecha/" +
                    me.desdeCA +
                    "/" +
                    me.hastaCA,
                configuracion
                )
                .then(function (response) {
                me.reporteCotizacion = response.data;
                me.resultPantalla(); //Cierre de pantalla
                }).catch(err => {
                        me.resultPantalla() //Cierre de pantalla
                        if (err.response.status==401){
                            me.activarErrores(1);
                        }
                        else if (err.response.status == 403){
                            me.activarErrores(2,"Error de permisos.","orange"); 
                        }
                        else{
                            me.activarErrores(2,err.response.data,"red");
                        }
                        console.log(err.response);
                    });
            }
        },

        //Metodos que generan los reportes
        crearPDFAutotableCotizacionAprobada() {
        if (
            !this.desdeCA ||
            !this.hastaCA ||
            this.reporteCotizacion.length <= 0
        ) {
            this.activarErrores(2,"Reporte Vacio","red"); //error
            return;
        }
        var columns = [
            { title: "Id Ingreso", dataKey: "id_ingreso" },
            { title: "Código articulo", dataKey: "codigo_arti" },
            { title: "Nombre articulo", dataKey: "nom_arti" },
            { title: "Proveedor", dataKey: "proveedor" },
            { title: "Cantidad", dataKey: "cantidad" },
            { title: "Valor", dataKey: "valor" },
            { title: "Fecha", dataKey: "fecha" },
        ];
        var rows = [];

        this.reporteCotizacion.map(function (x) {
            rows.push({
            id_ingreso 
            codigo_arti: x.codigo_arti,
            nom_arti: x.nom_arti,
            cantidad: x.cantidad,
            valor: x.valor,
            fecha: x.fecha,

            });
        });

        // Only pt supported (not mm or in)
        var doc = new jsPDF("p", "pt");
        doc.setFontSize(24);
        doc.setFont('Roboto-Regular', 'bold');
        var titulo = "INGRESOS";
        /*var ruc = this.cabeceraReport.numRuc;
        var direccion = this.cabeceraReport.direccion;
        var correo = this.cabeceraReport.correo;
        var telefono = this.cabeceraReport.telefono;
        var celular = this.cabeceraReport.celular;
        var pagina = this.cabeceraReport.paginaWeb;
        var desde = this.desdeCA;
        var hasta = this.hastaCA;*/

        //var imgData =this.$imgLogo;
            

        //TEXTO
        doc.setTextColor(12, 34, 82);
        // doc.setFontType(bold);
        doc.addImage(imgData, "JPEG", 20, 50, 150, 70);
        
        // doc.setFontType(bold);
        doc.text(titulo, 120, 50);
        doc.setFontSize(13);
        doc.text(ruc, 400, 90);
        //fecha
        doc.text("Desde:", 320, 130);
        doc.text(desde, 320, 150);
        doc.text("Hasta:", 450, 130);
        doc.text(hasta, 450, 150);

        doc.autoTable(columns, rows, {
            startY: 200,
        });
        //totales
        var x = 295;

        doc.setFontSize(10);
        doc.text(direccion, x -(direccion.length*2), doc.lastAutoTable.finalY + 80);


        //doc.save('Prestamos por rango de fecha.pdf');
        doc.output("dataurlnewwindow", {
            filename: "Ingresos.pdf",
        });


        }
  },
};
</script>

<style>
#principal {
  height: 600px !important;
}
.RecuperacionQuincena {
  height: 400px !important;
}
.cabecera {
  margin-top: 2% !important;
  text-align: center !important;
  font-family: arial !important;
  color: #174875 !important;
}

.cabecera h3,
h2,
h1 {
  margin-bottom: 2% !important;
}

.cabecera h3 {
  text-align: right !important;
}

.caja {
  display: flex !important;
  color: black !important;
  flex-flow: row-reverse !important;
  font-size: 13px !important;
  margin-bottom: 5% !important;
}
.caja h3 {
  margin-left: 2% !important;
}
.tabla {
  width: 100% !important;
  border: 1px solid #000 !important;
}
th,
td {
  text-align: left !important;
  vertical-align: top !important;
  border-collapse: collapse !important;
  padding: 0.3em !important;
  caption-side: bottom !important;
}
.footer {
  margin-top: 5% !important;
  flex-flow: column !important;
  display: flex !important;
}
.footer strong {
  margin-top: 2% !important;
}
.imagen {
  text-align: center !important;
}
.imagen > img {
  width: 40% !important;
}
.texto {
  font-size: 14px;
}
#select- {
  margin-top: 10px;
}
#fechas{
    display: flex;
    width: 85%;
}
.btn-color{
    color:white !important;
}
</style>