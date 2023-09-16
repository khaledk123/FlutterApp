// ignore: file_names
import 'package:flutter/material.dart';

class EmergancyContactsSearchBar extends StatefulWidget {
  const EmergancyContactsSearchBar({Key? key}) : super(key: key);

  @override
  State<EmergancyContactsSearchBar> createState() => _TestState();
}

//late String filternames;
class _TestState extends State<EmergancyContactsSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch(),
                  );
                },
                icon: const Icon(Icons.search))
          ],
          title: const Text('Global Emergancy Contacts'),
        ),
        body: const Center(
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    'Press on the Search Icon in the SearchBar\nType the Country name or initial letters',
                    style: TextStyle(fontSize: 25, color: Colors.black45))
                // Row(
                //   children: [
                //     Text('               Press on the Search Icon in the SearchBar'),
                // Text('Type the Country name or initial letters',
                // style: TextStyle(fontSize: 10, color: Colors.black45))
                // ],
                )));
    //);
  }
}

class DataSearch extends SearchDelegate {
  List names = [
    'Global Emergancy Number - 112'
    'Egypt Police - 122 ',
    'Egypt Ambulance - 123',
    'Egypt Fire DEP - 180',
    'Egypt Tourist police - 126',
    'Egypt Traffic police - 128',
    'Egypt Electricity emergency - 121',
    'Egypt Gas emergency - 129',
    'Egypt Mobile phones - 112.',
    'Algeria - 1548',
    'Algeria - 14',
    'Morocco - 19',
    'Morocco - 15',
    'emergency disturbances - 110',
    'United States - 911',
    'America - 911',
    'Iraq - 112 or 911',
    'Iran - 110 or 115 or 125',
    'Japan - 110 or 119',
    'Jordan - 911',
    'Kuwait - 112',
    'Lebanon - 999 or 112',
    'Saudi Arabia - 911',
    'India - 112',
    'China - 110 or 120 or 119',
    'Bahrain - 112',
    'Bahrain - 119',
    'France - 17',
    'France - 12',
    'France - 112',
    'France - 15',
    'France - 112',
    'France - 18',
    'France children - 119',
    'Italy Police - 113',
    'Italy Ambulance - 118',
    'Italy Fire Department - 115',
    'Russia Police - 102',
    'Russia Ambulance - 103',
    'Russia Fire Department - 101',
    'Russia Gas Emergency - 104',
    'Spain National Police - 091',
    'Spain Municipal Police - 092',
    'Spain Ambulance - 061',
    'Spain  Local Firefighters - 080',
    'Spain Autonomic Firefighters - 085',
    'Turkey Municipal police - 153',
    'Turkey Gas Emergency - 187',
    'Turkey Electricity Emergency - 186',
    'Turkey Water Emergency - 185',
    'Turkey Child Abuse and Family Violence - 183',
    'Greece Police - 100',
    'Greece Ambulance - 166',
    'Greece Fire Department - 199',
    'Germany Police - 110',
    'Germany Fire Department - 112',
    'Austria Police - 133',
    'Austria Ambulance - 144',
    'Austria Fire Department - 122',
    'Paraguay Police - 912',
    'Paraguay Ambulance - 141',
    'Paraguay Fire Department - 132',
    'Peru Police - 105',
    'Peru Ambulance - 106',
    'Peru Fire Department - 116',
    'Peru Civil Defense - 115',
    'Guyana Police - 911',
    'Guyana Ambulance - 913',
    'Guyana Fire Department - 912',
    'Brazil Police - 190',
    'Brazil Federal Highway Police - 191',
    'Brazil Federal Police - 194',
    'Brazil Civil Police - 197',
    'Brazil State Highway Police - 198',
    'Brazil Ambulance - 192',
    'Brazil Fire Department - 193',
    'Brazil Civil Defense - 199',
    'Brazil Human Rights - 100',
    'Brazil Hotline Help - 188',
    'India Police 100',
    'India Ambulance - 108',
    'India Fire Department - 101',
    'India Gas Emergency - 1906',
    'India Women Helpline - 181',
    'India Child Helpline - 1098',
    'Argentina Police - 101',
    'Argentina Ambulance - 107',
    'Argentina Fire Department - 100',
    'Argentina Civil Defense - 103',
    'Argentina Coast Guard - 106',
    'Cuba Police - 106',
    'Cuba Ambulance - 104',
    'Cuba Fire Department - 105',
    'Jamaica Police - 119',
    'Jamaica Ambulance - 110',
    'Haiti Police - 114',
    'Haiti Ambulance - 116',
    'Haiti Fire Department - 115',
    'Nicaragua Police - 118',
    'Nicaragua Ambulance - 128',
    'Nicaragua Fire Department - 115',
    'Guatemala Police - 110',
    'Guatemala Ambulance - 128',
    'Guatemala Fire Department - 122',
    'Australia Police - 131',
    'Cook Islands Police - 999',
    'Cook Islands Ambulance - 998',
    'Cook Islands Fire Department - 996',
    'Ukraine Police - 102',
    'Ukraine Ambulance - 103',
    'Ukraine Fire Department - 101',
    'Ukraine Gas Emergency - 104',
    'Romania - 911',
    'Poland Police - 112',
    'Poland Municipal Police - 986',
    'Poland Mountain Rescue - 985',
    'Poland Ambulance - 999',
    'Poland Fire Department - 998',
    'Poland Gas Emergency - 992',
    'Poland Road Help - 981',
    'Monaco Police - 17',
    'Monaco Ambulance - 15',
    'Monaco Fire Department - 18',
    'Luxembourg Police - 113',
    'Armenia Police - 102',
    'Armenia Ambulance - 103',
    'Armenia Fire Department - 101',
    'Armenia Gas Emergency - 104',
    'Armenia Search and Rescue - 108',
    'Bahrain Police - 999',
    'Bahrain Traffic Police - 199',
    'Bahrain Coast Guard - 994',
    'United Arab Emirates Police - 911',
    'United Arab Emirates Ambulance - 998',
    'United Arab Emirates Fire Department - 997',
    'United Arab Emirates Electricity Emergency - 991',
    'Indonesia Police - 110',
    'Indonesia Ambulance - 118',
    'Indonesia Ambulance - 119',
    'Indonesia Fire Department - 113',
    'Indonesia Fire Department - 1131',
    'Indonesia Search & Rescue - 115',
    'Indonesia Electricity Emergency - 123',
    'Maldives Police - 119',
    'Maldives Ambulance - 102',
    'Maldives Fire Department - 118',
    'Tunisia Police - 197',
    'Tunisia Ambulance - 190',
    'Tunisia Fire Department - 198',
    'Niger Police - 17',
    'Niger Ambulance - 15',
    'Niger Fire Department - 18',
    'Guinea Police - 117',
    'Guinea Ambulance - 18',
    'Guinea Fire Department - 442020',
    'Yemen Police - 194',
    'Yemen Fire Department - 191',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {

    //the search results
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //the end result
    List filternames =
        names.where((element) => element.contains(query)).toList();
    return ListView.builder(
        itemCount: query == '' ? names.length : filternames.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              showResults(context);
              query = query == '' ? names[i] : filternames[i];
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: query == ""
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 30),
                        child: Material(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${names[i]}",
                              // query==""?"${names[i]}":"${filternames[i]}",
                              style:
                                  const TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    )
                  :Text("${filternames[i]}", style: const TextStyle(fontSize: 25)),
            ),
          );
        });
  }
}
