<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="white">
                <v-toolbar-title>Categorías</v-toolbar-title>
                    <v-divider
                    class="mx-2"
                    inset
                    vertical
                    ></v-divider>
                    <v-spacer></v-spacer>
                    <v-text-field class="text-xs-center" v-model="search" append-icon="search" label="Búsqueda" single-line hide-details></v-text-field>
                    <v-spacer></v-spacer>
                    <v-dialog v-model="dialog" max-width="500px" persistent>
                        <v-btn slot="activator" color="primary" dark class="mb-2">Nuevo</v-btn>
                        <v-card>
                            <v-card-title>
                            <span class="headline">{{ formTitle }}</span>
                            </v-card-title>
                
                            <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="nombre" label="Nombre"></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm12 md12>
                                    <v-text-field v-model="descripcion" label="Descripción"></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm12 md12 v-show="valida">
                                    <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v">
                                    </div>
                                </v-flex>
                                </v-layout>
                            </v-container>
                            </v-card-text>
                
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="blue darken-1" flat @click.native="close">Cancelar</v-btn>
                                <v-btn color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                    <v-dialog v-model="adModal" max-width="290" persistent>
                        <v-card>
                            <v-card-title class="headline" v-if="adAccion==1">¿Activar Item?</v-card-title>
                            <v-card-title class="headline" v-if="adAccion==2">¿Desactivar Item?</v-card-title>
                            <v-card-text>
                                Estás a punto de 
                                <span v-if="adAccion==1">Activar </span>
                                <span v-if="adAccion==2">Desactivar </span>
                                el ítem {{ adNombre }}
                            </v-card-text>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="green darken-1" flat="flat" @click="activarDesactivarCerrar">
                                    Cancelar
                                </v-btn>
                                <v-btn v-if="adAccion==1" color="orange darken-4" flat="flat" @click="activar">
                                    Activar
                                </v-btn>
                                <v-btn v-if="adAccion==2" color="orange darken-4" flat="flat" @click="desactivar">
                                    Desactivar
                                </v-btn>
                            </v-card-actions>

                        </v-card>
                    </v-dialog>
            </v-toolbar>
            <v-data-table
                :headers="headers"
                :items="categorias"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">
                    <td class="justify-center layout px-0">
                        <v-icon
                        small
                        class="mr-2"
                        @click="editItem(props.item)"
                        >
                        edit
                        </v-icon>
                        <template v-if="props.item.condicion">
                            <v-icon
                            small
                            @click="activarDesactivarMostrar(2,props.item)"
                            >
                            block
                            </v-icon>
                        </template>
                        <template v-else>
                            <v-icon
                            small
                            @click="activarDesactivarMostrar(1,props.item)"
                            >
                            check
                            </v-icon>
                        </template>
                    </td>
                    <td>{{ props.item.nombre }}</td>
                    <td>{{ props.item.descripcion }}</td>
                    <td>
                        <div v-if="props.item.condicion">
                            <span class="blue--text">Activo</span>
                        </div>
                        <div v-else>
                            <span class="red--text">Inactivo</span>
                        </div>
                    </td>
                </template>
                <template slot="no-data">
                <v-btn color="primary" @click="listar">Resetear</v-btn>
                </template>
            </v-data-table>
            <!-- PANTALLA DE CARGA-->
            <PantallaCarga :activo="carga" @escucharResultPantalla="resultPantalla()"> </PantallaCarga>
             <!-- DIALOGO DE ERROR-->
           <Mensaje :activo="activarError" :msj="msjError" :tipo="tipoMsj" @escucharResultMsj="resultMsj()"> </Mensaje>
            <!--- CIERRE DE SECION --->
            <Secion :activo="login_" @escucharResult="resultHijo()" ></Secion>

        </v-flex>
    </v-layout>
</template>
<script>
    import axios from 'axios';
    import Secion from '@/components/Secion'
    import Mensaje from '@/components/Mensaje';
    import PantallaCarga from '@/components/PantallaCarga';

    export default {
        data(){
            return {
                categorias:[],                
                dialog: false,
                headers: [
                    { text: 'Opciones', value: 'opciones', sortable: false },
                    { text: 'Nombre', value: 'nombre' },
                    { text: 'Descripción', value: 'descripcion', sortable: false  },
                    { text: 'Estado', value: 'condicion', sortable: false  }                
                ],
                search: '',
                editedIndex: -1,
                id: '',
                nombre: '',
                descripcion: '',
                valida: 0,
                validaMensaje:[],
                adModal: 0,
                adAccion: 0,
                adNombre: '',
                adId: '',
                login_:false,
                tipoMsj:'',
                msjError:'',
                activarError:false,
                carga:false,             
            }
        },
        computed: {
            formTitle () {
                return this.editedIndex === -1 ? 'Nueva categoría' : 'Actualizar categoría'
            }
        },
        components:{
            Secion,
            Mensaje,
            PantallaCarga
        },

        watch: {
            dialog (val) {
            val || this.close()
            }
        },

        created () {
            this.listar();
        },
        methods:{
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
            listar(){
                this.carga = true;
                let me=this;
                let header={"Authorization" : "Bearer " + this.$store.state.token};
                let configuracion= {headers : header};
                axios.get('api/Categorias/Listar',configuracion).then(function(response){
                    //console.log(response);
                    me.categorias=response.data;
                    me.resultPantalla();
                }).catch(function(err){
                    me.resultPantalla(); //Cierre de pantalla
                    if (err.response.status==401){
                        me.activarErrores(1);
                    }
                    else if (err.response.status == 403){
                        me.activarErrores(2,"Error de permisos.","orange"); 
                    }
                    else{
                        me.activarErrores(2,err.response.data,"red");
                    }

                });
            },
            editItem (item) {
                this.id=item.idcategoria;
                this.nombre=item.nombre;
                this.descripcion=item.descripcion;
                this.editedIndex=1;
                this.dialog = true
            },
            close () {
                this.dialog = false;
                this.limpiar();
            },
            limpiar(){
                this.id="";
                this.nombre="";
                this.descripcion="";
                this.validaMensaje = [];
                this.editedIndex=-1;
            },
            guardar () {
                if (this.validar()){
                    return;
                }
                let header={"Authorization" : "Bearer " + this.$store.state.token};
                let configuracion= {headers : header};
                if (this.editedIndex > -1) {
                    this.carga = true;
                    //Código para editar
                    //Código para guardar
                    let me=this;
                    axios.put('api/Categorias/Actualizar',{
                        'idcategoria':me.id,
                        'nombre': me.nombre,
                        'descripcion': me.descripcion
                    },configuracion).then(function(response){
                        me.close();
                        me.listar();
                        me.limpiar(); 
                        me.resultPantalla();    
                        me.activarErrores(2,"Actualizado Correctamente.","green");                          
                    }).catch(function(err){
                        me.resultPantalla(); //Cierre de pantalla
                        if (err.response.status==401){
                            me.activarErrores(1);
                        }
                        else if (err.response.status == 403){
                            me.activarErrores(2,"Error de permisos.","orange"); 
                        }
                        else{
                            me.activarErrores(2,err.response.data,"red");
                        }

                    });
                } else {
                    //Código para guardar
                    this.carga = true;
                    let me=this;
                    axios.post('api/Categorias/Crear',{
                        'nombre': me.nombre,
                        'descripcion': me.descripcion
                    },configuracion).then(function(response){
                        me.close();
                        me.listar();
                        me.limpiar();      
                        me.resultPantalla();            
                        me.activarErrores(2,"Guardado Correctamente.","green");             
                    }).catch(function(err){
                        me.resultPantalla(); //Cierre de pantalla
                        if (err.response.status==401){
                            me.activarErrores(1);
                        }
                        else if (err.response.status == 403){
                            me.activarErrores(2,"Error de permisos.","orange"); 
                        }
                        else{
                            me.activarErrores(2,err.response.data,"red");
                        }

                    });
                }
            },
            validar(){
                this.valida=0;
                this.validaMensaje=[];

                if (this.nombre.length<3 || this.nombre.length>50){
                    this.validaMensaje.push("El nombre debe tener más de 3 caracteres y menos de 50 caracteres");
                }
                if (this.validaMensaje.length){
                    this.valida=1;
                }
                return this.valida;
            },
            activarDesactivarMostrar(accion,item){
                this.adModal=1;
                this.adNombre=item.nombre;
                this.adId=item.idcategoria;                
                if (accion==1){
                    this.adAccion=1;
                }
                else if (accion==2){
                    this.adAccion=2;
                }
                else{
                    this.adModal=0;
                }
            },
            activarDesactivarCerrar(){
                this.adModal=0;
            },
            activar(){
                this.carga = true;
                let me=this;
                let header={"Authorization" : "Bearer " + this.$store.state.token};
                let configuracion= {headers : header};
                axios.put('api/Categorias/Activar/'+this.adId,{},configuracion).then(function(response){
                    me.adModal=0;
                    me.adAccion=0;
                    me.adNombre="";
                    me.adId="";
                    me.listar();             
                    me.resultPantalla();          
                    me.activarErrores(2,"Activado Correctamente.","green"); 
                }).catch(function(err){
                    me.resultPantalla(); //Cierre de pantalla
                    if (err.response.status==401){
                        me.activarErrores(1);
                    }
                    else if (err.response.status == 403){
                        me.activarErrores(2,"Error de permisos.","orange"); 
                    }
                    else{
                        me.activarErrores(2,err.response.data,"red");
                    }
                });
            },
            desactivar(){
                this.carga = true;
                let me=this;
                let header={"Authorization" : "Bearer " + this.$store.state.token};
                let configuracion= {headers : header};
                axios.put('api/Categorias/Desactivar/'+this.adId,{},configuracion).then(function(response){
                    me.adModal=0;
                    me.adAccion=0;
                    me.adNombre="";
                    me.adId="";
                    me.listar(); 
                    me.resultPantalla();           
                    me.activarErrores(2,"Desactivado Correctamente.","green");            
                }).catch(function(err){
                    me.resultPantalla(); //Cierre de pantalla
                    if (err.response.status==401){
                        me.activarErrores(1);
                    }
                    else if (err.response.status == 403){
                        me.activarErrores(2,"Error de permisos.","orange"); 
                    }
                    else{
                        me.activarErrores(2,err.response.data,"red");
                    }
                });
            }
        }        
    }
</script>
