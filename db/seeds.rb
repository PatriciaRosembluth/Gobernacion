# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create([{typename: 'ADMIN'}, {typename: 'RECEPTIONISTA'}, {typename: 'REPRESENTANTE LEGAL'}, {typename: 'JEFE'}, {typename: 'REVISOR'}])

test_user = User.new
test_user.email = 'admin@gmail.com'
test_user.username = 'admin'
test_user.active = true
test_user.password = 'adminadmin'
test_user.role = 1
test_user.save!
Person.create(first_name:'Armin',last_name:'Trandor',
              identification_number:'554352521',
              identification_type:'1',
              country:'BO',
              city:'C',
              address:'Por alla',user_id:1,phone_number:'70728566')
Employee.create(position:'1',profession:'Administrador de empresas',agent_id:'1234s',person_id:1)

test_user = User.new
test_user.email = 'recepcionist@gmail.com'
test_user.username = 'recepcionist'
test_user.active = true
test_user.password = 'adminadmin'
test_user.role = 2
test_user.save!
Person.create(first_name:'Rebeca',last_name:'Nista',
              identification_number:'234234',identification_type:'1',
              country:'BO',city:'C',address:'Por alla',
              user_id:2,phone_number:'70728566')
Employee.create(position:'2',profession:'Secretaria',agent_id:'3234s',person_id:2)

test_user = User.new
test_user.email = 'legalAgent1@gmail.com'
test_user.username = 'legalAgent1'
test_user.active = true
test_user.password = 'adminadmin'
test_user.role = 3
test_user.save!
Person.create(first_name:'Reprendo',last_name:'Legolo',identification_number:'5246352521',
              identification_type:'1',country:'BO',city:'C',address:'Por alla',
              user_id:3,phone_number:'70728566')
LegalAgent.create(company_id:1,person_id:3)

test_user = User.new
test_user.email = 'jefeUnidad@gmail.com'
test_user.username = 'jefeUnidad'
test_user.active = true
test_user.password = 'adminadmin'
test_user.role = 4
test_user.save!
Person.create(first_name:'Juan',last_name:'Perez',identification_number:'554546221',
              identification_type:'1',country:'BO',city:'C',
              address:'Por alla',user_id:4,phone_number:'70728566')
Employee.create(position:'4',profession:'Ingeniero Ambiental',agent_id:'2534s',person_id:4)

test_user = User.new
test_user.email = 'revisor@gmail.com'
test_user.username = 'revisor'
test_user.active = true
test_user.password = 'adminadmin'
test_user.role = 5
test_user.save!
Person.create(first_name:'Abundio',
              last_name:'Resorio',identification_number:'7563352521',
              identification_type:'1',country:'BO',city:'C',
              address:'Por alla',user_id:5,phone_number:'70728566')
Employee.create(position:'5',profession:'Abogado',agent_id:'4234s',person_id:5)

Company.create(name:'Hipermaxi',principal_activity:'Comercio',nit:'22343534',address:'Av. Blanco Galindo',zone:'Sarco',departament:'Cochabamba',phones:'4420343',email:'hipermaxi@hiper.com')
Company.create(name:'Manaco',principal_activity:'Comercio',nit:'22343534',address:'Av. Blanco Galindo',zone:'Sarco',departament:'Cochabamba',phones:'4420343',email:'hipermaxi@hiper.com')
Company.create(name:'Hipermaxi',principal_activity:'Comercio',nit:'22343534',address:'Av. Blanco Galindo',zone:'Sarco',departament:'Cochabamba',phones:'4420343',email:'hipermaxi@hiper.com')

#Lista de verificacion del recepcionista (type:1) para verificar si se entregaron todos los documentos

ListCategory.create(name:'Cumplimiento de requisitos administrativos y legales')  #1
ListCategory.create(name:'Cumplimiento de Criterios Tecnicos')                    #2
ListCategory.create(name:'Cumplimiento de Informacion Tecnica Respaldatoria')     #3

ProcedureType.create([
                         {name: 'L.A. Multisector'},        #1
                         {name: 'L.A. Sector Industrial'},  #2
                         # {name: 'L.A. Sector Minero'}       #3
                     ])

#Documentos Multisector
Document.create([
                    {typename: 'Ficha Ambiental (FA)'},
                    {typename: 'Estudio de Evaluacion de Impacto Ambiental (EEIA)'},
                    {typename: 'Programa de Prevencion y Mitigacion y Plan de Aplicacion y Seguimiento Ambiental (PPM-PASA)'},
                    {typename: 'Manifiesto Ambiental (MA)'}
                ])

Requirement.create([
                       {procedure_type_id: 1, document_id: 1},
                       {procedure_type_id: 1, document_id: 2},
                       {procedure_type_id: 1, document_id: 3},
                       {procedure_type_id: 1, document_id: 4}
                   ])

VerificationList.create(name:'Requisitos F.A.',list_category_id:2) #1
VerificationField.create(description:'Tiene boleta ORIGINAL de deposito bancario por pago de PCEIA',verification_list_id:1)
VerificationField.create(description:'Certificado RENCA actualizado del Consultor Ambiental responsable, hasta la fecha de ingreso en la instancia donde inicia su tramite.',verification_list_id:1)
VerificationField.create(description:'NIT de la empresa',verification_list_id:1)
VerificationField.create(description:'Registro de fundempresa',verification_list_id:1)
VerificationField.create(description:'Derecho propietario del predio, contrato de arrendamiento o certificacion similar.',verification_list_id:1)
Revision.create({document_id: 1, verification_list_id: 1})

VerificationList.create(name:'Requisitos E.E.I.A',list_category_id:2)
VerificationField.create(description:'Certificado RENCA actualizado del equipo de Consultores Ambientales responsables',verification_list_id:2)
VerificationField.create(description:'Declaración jurada firmada en ORIGINAL por el Representante Legal y Consultor Ambiental',verification_list_id:2)
VerificationField.create(description:'NIT de la empresa',verification_list_id:2)
VerificationField.create(description:'Registro de fundempresa',verification_list_id:2)
VerificationField.create(description:'Derecho propietario del predio, contrato de arrendamiento o certificacion similar.',verification_list_id:2)
VerificationField.create(description:'Certificado de Uso de Suelo extendido por la instancia correspondiente del GAM.',verification_list_id:2)
Revision.create({document_id: 2, verification_list_id: 2})

VerificationList.create(name:'Requisitos P.P.M - P.A.S.A',list_category_id:2)
VerificationField.create(description:'Certificado RENCA actualizado del equipo de Consultores Ambientales responsables',verification_list_id:3)
VerificationField.create(description:'Declaración jurada firmada en ORIGINAL por el Representante Legal y Consultor Ambiental',verification_list_id:3)
VerificationField.create(description:'NIT de la empresa',verification_list_id:3)
VerificationField.create(description:'Registro de fundempresa',verification_list_id:3)
VerificationField.create(description:'Memorial de solicitud de registro y licencia para actividades con sustancias peligrosas',verification_list_id:3)
VerificationField.create(description:'Verificar los antecedentes contenidos en el expediente del proyecto',verification_list_id:3)
Revision.create({document_id: 3, verification_list_id: 3})

VerificationList.create(name:'Requisitos M.A.',list_category_id:2)
VerificationField.create(description:'Certificado RENCA actualizado del equipo de Consultores Ambientales responsables',verification_list_id:4)
VerificationField.create(description:'Testimonio de constitución de la Sociedad y poder notariado del RL ',verification_list_id:4)
VerificationField.create(description:'Instrumento legal de designación del Promotor',verification_list_id:4)
VerificationField.create(description:'NIT de la empresa',verification_list_id:4)
VerificationField.create(description:'Certificado de Uso de Suelo extendido por la instancia correspondiente del GAM.',verification_list_id:4)
VerificationField.create(description:'Resolucion de aprobacion del Plan de Higiene y Seguridad del Ministerio de Trabajo',verification_list_id:4)
Revision.create({document_id: 4, verification_list_id: 4})

#Documentos Sector Industrial
Document.create([
    {typename: 'Registro Ambiental Industrial (RAI)' },                                               #5
    {typename: 'Estudio de Evaluación de Impacto Ambiental - Plan de Manejo Ambiental (EEIA-PMA)' },  #6
    {typename: 'Descripción del Proyecto - Plan de Manejo Ambiental (DP-PMA)' },                      #7
    {typename: 'Manifiesto Ambiental Industrial – Plan de Manejo Ambiental (MAI-PMA)' }               #8
      ])

Requirement.create([
                       {procedure_type_id: 2, document_id: 5},
                       {procedure_type_id: 2, document_id: 6},
                       {procedure_type_id: 2, document_id: 7},
                       {procedure_type_id: 2, document_id: 8}
                   ])

VerificationList.create(name:'Requisitos R.A.I.',list_category_id:2)
VerificationField.create([
{description:'Instrumento legal de designación del Promotor para la Industria en  entidades estatales',verification_list_id:5},
{description:'CI del RL y Consultor Ambiental',verification_list_id:5},
{description:'Certificado RENCA actualizado del Consultor Ambiental responsable',verification_list_id:5},
{description:'Certificado de Uso de Suelo extendido por la instancia  correspondiente del GAM',verification_list_id:5},
{description:'Testimonio de constitución de la Sociedad (si corresponde)',verification_list_id:5},
{description:'Poder Notariado de Representante Legal de la Sociedad',verification_list_id:5},
{description:'Declaración jurada firmada en ORIGINAL por el Representante Legal y Consultor Ambiental',verification_list_id:5},
{description:'Verificar los antecedentes contenidos en el expediente de la  Industria (en caso de que éste exista en los Archivos del UGCA).',verification_list_id:5}
  ])
Revision.create({document_id: 5, verification_list_id: 5})

VerificationList.create(name:'Requisitos E.E.I.A. - P.M.A.',list_category_id:2)
VerificationField.create([
{description:'La industria ha sido categorizada como 1-2',verification_list_id:6},
{description:'Cédula de Identidad del RL y Consultor Ambiental',verification_list_id:6},
{description:'Instrumento legal de designación del Promotor',verification_list_id:6},
{description:'NIT de la Empresa',verification_list_id:6},
{description:'Derecho propietario del predio, contrato de arrendamiento o certificación similar',verification_list_id:6},
{description:'Fotocopia del permiso del IBTEN en caso de utilización de sustancias  radioactivas, si corresponde',verification_list_id:6},
{description:'Expediente de la industria en caso de que exista en archivos de la  UGCA',verification_list_id:6},
{description:'Registro de FUNDEMPRESA',verification_list_id:6}
])
Revision.create({document_id: 6, verification_list_id: 6})

VerificationList.create(name:'Requisitos D.P. - P.M.A.',list_category_id:2)
VerificationField.create([
{description:'La industria ha sido categorizada como 3',verification_list_id:7},
{description:'Cédula de Identidad del RL y Consultor Ambiental',verification_list_id:7},
{description:'Testimonio de constitución de la Sociedad y poder notariado del RL',verification_list_id:7},
{description:'Derecho propietario del predio, contrato de arrendamiento',verification_list_id:7},
{description:'NIT de la Empresa',verification_list_id:7},
{description:'Registro de FUNDEMPRESA',verification_list_id:7},
{description:'Hojas de Seguridad para las Sustancias Peligrosas Identificadas',verification_list_id:7},
{description:'Análisis de Riesgo Industrial',verification_list_id:7}
                         ])
Revision.create({document_id: 7, verification_list_id: 7})

VerificationList.create(name:'Requisitos M.A.I - P.M.A.',list_category_id:2)
VerificationField.create([
{description:'La industria ha sido categorizada como 1-2',verification_list_id:8},
{description:'Testimonio de constitución de la Sociedad y poder notariado del RL',verification_list_id:8},
{description:'Certificado RENCA',verification_list_id:8},
{description:'NIT de la Empresa',verification_list_id:8},
{description:'Registro de FUNDEMPRESA',verification_list_id:8},
{description:'Certificado de Uso de Suelo extendido por la instancia correspondiente del GAM',verification_list_id:8},
{description:'Fotocopia del permiso del IBTEN en caso de utilización de sustancias  radioactivas',verification_list_id:8},
{description:'Expediente de la industria en caso de que exista en archivos de la  UGCA',verification_list_id:8},
                         ])
Revision.create({document_id: 8, verification_list_id: 8})

#Documentos sector minero
# Document.create([
#     {typename: 'Formulario de Prospección Minera (PM)'},
#     {typename: 'Formulario de Exploración Minera y Actividades Pequeñas (EMAP)'},
#     {typename: 'Formulario para la Explotación Menor de Áridos y Agregados (EMAR)'},
#     {typename: 'Formulario de Solicitud de Certificado de Dispensación (FSCD)'}
#       ])
#
# Requirement.create([
#                        {procedure_type_id: 3, document_id: 9},
#                        {procedure_type_id: 3, document_id: 10},
#                        {procedure_type_id: 3, document_id: 11},
#                        {procedure_type_id: 3, document_id: 12}
#                    ])