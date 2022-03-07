//
//  EtiquetteListView.swift
//  Restaurangular (iOS)
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI

struct EtiquetteListView: View {
    
    @StateObject var etiquette : Etiquette = Etiquette()
    
    @State var decrement = false
    
    
    func exportToPDF(width:CGFloat, height:CGFloat) {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let outputFileURL = documentDirectory.appendingPathComponent("\(self.etiquette.id_recette)-\(Date()).pdf")
            //Normal with
            let width: CGFloat = width
            //Estimate the height of your view
            let height: CGFloat = height
            let charts = EtiquetteListView(etiquette: self.etiquette)
            let pdfVC = UIHostingController(rootView: charts)
            pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            //Render the view behind all other views
            let rootVC = UIApplication.shared.windows.first?.rootViewController
            rootVC?.addChild(pdfVC)
            rootVC?.view.insertSubview(pdfVC.view, at: 0)
            //Render the PDF

            let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: width, height: height))
            DispatchQueue.main.async {
                do {
                    try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                        context.beginPage()
                        rootVC?.view.layer.render(in: context.cgContext)
                    })
                    UserDefaults.standard.set(outputFileURL, forKey: "pdf")
                    UserDefaults.standard.synchronize()
                    print("wrote file to: \(outputFileURL.path)")
                } catch {
                    print("Could not create PDF file: \(error.localizedDescription)")
                }

            pdfVC.removeFromParent()
            pdfVC.view.removeFromSuperview()
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing:30){
                VStack{
                    Text("Choisissez une recette").bold()
                    Section{
                        Picker("Recette : ", selection: $etiquette.id_recette) {
                            ForEach(etiquette.recetteList.recette_list, id:\.id_recette){item in
                                    Text(item.nom_recette)
                            }
                        }
                    }
                }
                Divider()
                Text("Aperçu de votre étiquette").bold()
                VStack(spacing:20){
                    HStack(spacing:20){
                        Text(etiquette.recette.nom_categorie+": ").bold()
                        Text(etiquette.recette.nom_recette).bold()
                    }
                    VStack{
                        Text("Ingrédients: ").bold()
                        if let i = etiquette.recette.ingredients{
                            ForEach(i,id:\.id_ingredient){ ingr in
                                Text(ingr.nom_ingredient)
                            }
                        }
                    }
                    VStack{
                        Text("Allergènes").bold()
                    }
                    VStack{
                        Text("Prix : \(etiquette.recette.prix_vente,specifier:"%.2f") €").bold()
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black,lineWidth: 2)
                )
                .foregroundColor(Color.red)
                HStack(spacing:5){
                    Toggle("Décrémentation du stock",isOn:$decrement)
                    if decrement{
                        Text("Avec")
                    }
                    else{
                        Text("Sans")
                    }
                }.padding()
                HStack(spacing:5){
                    Button("Imprimer"){
                        
                        exportToPDF(width: 200, height: 200)
                    }
                }.padding()
            }
            .navigationTitle("Etiquette")
            
        }
        .task{
            //  RECETTES
            if let list = await RecetteDAO.getAllRecette(){
                self.etiquette.recetteList.recette_list = list.sorted{$0.nom_recette < $1.nom_recette}
                print("Recette list : ",list)
            }
        }
    }
}

struct EtiquetteListView_Previews: PreviewProvider {
    static var previews: some View {
        EtiquetteListView()
    }
}
