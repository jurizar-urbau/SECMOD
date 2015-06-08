<form class="form-horizontal style-form" id="form" name="form" novalidate>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Razon Social</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.rzsocial"  >
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Cliente</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.client"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Telefono</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.tel"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Fax</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.fax"  >
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Telefono Alterno</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.telalt"  >
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Fax Alterno</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.faxalt"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Numero Fiscal</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.numfiscal"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Direccion Fiscal</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.addrfiscal"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Email</label>
                              <div class="col-sm-10">
                                  <input type="email" class="form-control"  ng-model="beanService.bean.email"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Rating</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.rating"  >
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Direccion</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.direcion"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Pais</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.pais"  >
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo Cliente</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.tipoCliente"  >
                              </div>
                        </div>
                         <div class="form-group">
                         
                              <label class="col-sm-2 col-sm-2 control-label">Vendedor</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.vendedor"  >
                              </div>
                          </div>
                          
                           <div class="form-actions">
                           	    <input  class="btn"  type="button" ng-click="reset()" value="Reset" />
 								<input type="submit" class="btn btn-success"  ng-click="update(beanService.bean)" value="Guardar" />
					        </div>  
                      </form>