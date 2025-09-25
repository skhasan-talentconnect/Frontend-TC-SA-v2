class StateCityAreaUtils {
  static final Map<String, List<String>> stateCities = {
    'Andaman and Nicobar Islands': ['Port Blair'],
    'Andhra Pradesh': ['Adoni', 'Amaravati', 'Anantapur', 'Chandragiri', 'Chittoor', 'Dowlaiswaram', 'Eluru', 'Guntur', 'Kadapa', 'Kakinada', 'Kurnool', 'Machilipatnam', 'Nagarjunakoṇḍa', 'Rajahmundry', 'Srikakulam', 'Tirupati', 'Vijayawada', 'Visakhapatnam', 'Vizianagaram', 'Yemmiganur'],
    'Arunachal Pradesh': ['Itanagar'],
    'Assam': ['Dhuburi', 'Dibrugarh', 'Dispur', 'Guwahati', 'Jorhat', 'Nagaon', 'Sivasagar', 'Silchar', 'Tezpur', 'Tinsukia'],
    'Bihar': ['Ara', 'Barauni', 'Begusarai', 'Bettiah', 'Bhagalpur', 'Bihar Sharif', 'Bodh Gaya', 'Buxar', 'Chapra', 'Darbhanga', 'Dehri', 'Dinapur Nizamat', 'Gaya', 'Hajipur', 'Jamalpur', 'Katihar', 'Madhubani', 'Motihari', 'Munger', 'Muzaffarpur', 'Patna', 'Purnia', 'Pusa', 'Saharsa', 'Samastipur', 'Sasaram', 'Sitamarhi', 'Siwan'],
    'Chandigarh': ['Chandigarh'],
    'Chhattisgarh': ['Ambikapur', 'Bhilai', 'Bilaspur', 'Dhamtari', 'Durg', 'Jagdalpur', 'Raipur', 'Rajnandgaon'],
    'Dadra and Nagar Haveli and Daman and Diu': ['Daman', 'Diu', 'Silvassa'],
    'Delhi': ['Delhi', 'New Delhi'],
    'Goa': ['Madgaon', 'Panaji'],
    'Gujarat': ['Ahmadabad', 'Amreli', 'Bharuch', 'Bhavnagar', 'Bhuj', 'Dwarka', 'Gandhinagar', 'Godhra', 'Jamnagar', 'Junagadh', 'Kandla', 'Khambhat', 'Kheda', 'Mahesana', 'Morbi', 'Nadiad', 'Navsari', 'Okha', 'Palanpur', 'Patan', 'Porbandar', 'Rajkot', 'Surat', 'Surendranagar', 'Valsad', 'Veraval'],
    'Haryana': ['Ambala', 'Bhiwani', 'Chandigarh', 'Faridabad', 'Firozpur Jhirka', 'Gurugram', 'Hansi', 'Hisar', 'Jind', 'Kaithal', 'Karnal', 'Kurukshetra', 'Panipat', 'Pehowa', 'Rewari', 'Rohtak', 'Sirsa', 'Sonipat'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Dalhousie', 'Dharmshala', 'Hamirpur', 'Kangra', 'Kullu', 'Mandi', 'Nahan', 'Shimla', 'Una'],
    'Jammu and Kashmir': ['Anantnag', 'Baramula', 'Doda', 'Gulmarg', 'Jammu', 'Kathua', 'Punch', 'Rajouri', 'Srinagar', 'Udhampur'],
    'Jharkhand': ['Bokaro', 'Chaibasa', 'Deoghar', 'Dhanbad', 'Dumka', 'Giridih', 'Hazaribag', 'Jamshedpur', 'Jharia', 'Rajmahal', 'Ranchi', 'Saraikela'],
    'Karnataka': ['Badami', 'Ballari', 'Bengaluru', 'Belagavi', 'Bhadravati', 'Bidar', 'Chikkamagaluru', 'Chitradurga', 'Davangere', 'Halebid', 'Hassan', 'Hubballi-Dharwad', 'Kalaburagi', 'Kolar', 'Madikeri', 'Mandya', 'Mangaluru', 'Mysuru', 'Raichur', 'Shivamogga', 'Shravanabelagola', 'Shrirangapattana', 'Tumakuru', 'Vijayapura'],
    'Kerala': ['Alappuzha', 'Vatakara', 'Idukki', 'Kannur', 'Kochi', 'Kollam', 'Kottayam', 'Kozhikode', 'Mattancheri', 'Palakkad', 'Thalassery', 'Thiruvananthapuram', 'Thrissur'],
    'Ladakh': ['Kargil', 'Leh'],
    'Madhya Pradesh': ['Balaghat', 'Barwani', 'Betul', 'Bharhut', 'Bhind', 'Bhojpur', 'Bhopal', 'Burhanpur', 'Chhatarpur', 'Chhindwara', 'Damoh', 'Datia', 'Dewas', 'Dhar', 'Dr. Ambedkar Nagar (Mhow)', 'Guna', 'Gwalior', 'Hoshangabad', 'Indore', 'Itarsi', 'Jabalpur', 'Jhabua', 'Khajuraho', 'Khandwa', 'Khargone', 'Maheshwar', 'Mandla', 'Mandsaur', 'Morena', 'Murwara', 'Narsimhapur', 'Narsinghgarh', 'Narwar', 'Neemuch', 'Nowgong', 'Orchha', 'Panna', 'Raisen', 'Rajgarh', 'Ratlam', 'Rewa', 'Sagar', 'Sarangpur', 'Satna', 'Sehore', 'Seoni', 'Shahdol', 'Shajapur', 'Sheopur', 'Shivpuri', 'Ujjain', 'Vidisha'],
    'Maharashtra': ['Ahmadnagar', 'Akola', 'Amravati', 'Aurangabad', 'Bhandara', 'Bhusawal', 'Bid', 'Buldhana', 'Chandrapur', 'Daulatabad', 'Dhule', 'Jalgaon', 'Kalyan', 'Karli', 'Kolhapur', 'Mahabaleshwar', 'Malegaon', 'Matheran', 'Mumbai', 'Nagpur', 'Nanded', 'Nashik', 'Osmanabad', 'Pandharpur', 'Parbhani', 'Pune', 'Ratnagiri', 'Sangli', 'Satara', 'Sevagram', 'Solapur', 'Thane','Santacruz','Bandra','Khar Road' ,'Ulhasnagar', 'Vasai-Virar', 'Wardha', 'Yavatmal'],
    'Manipur': ['Imphal'],
    'Meghalaya': ['Cherrapunji', 'Shillong'],
    'Mizoram': ['Aizawl', 'Lunglei'],
    'Nagaland': ['Kohima', 'Mon', 'Phek', 'Wokha', 'Zunheboto'],
    'Odisha': ['Balangir', 'Baleshwar', 'Baripada', 'Bhubaneshwar', 'Brahmapur', 'Cuttack', 'Dhenkanal', 'Kendujhar', 'Konark', 'Koraput', 'Paradip', 'Phulabani', 'Puri', 'Sambalpur', 'Udayagiri'],
    'Puducherry': ['Karaikal', 'Mahe', 'Puducherry', 'Yanam'],
    'Punjab': ['Amritsar', 'Batala', 'Chandigarh', 'Faridkot', 'Firozpur', 'Gurdaspur', 'Hoshiarpur', 'Jalandhar', 'Kapurthala', 'Ludhiana', 'Nabha', 'Patiala', 'Rupnagar', 'Sangrur'],
    'Rajasthan': ['Abu', 'Ajmer', 'Alwar', 'Amer', 'Barmer', 'Beawar', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittaurgarh', 'Churu', 'Dhaulpur', 'Dungarpur', 'Ganganagar', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalor', 'Jhalawar', 'Jhunjhunu', 'Jodhpur', 'Kishangarh', 'Kota', 'Merta', 'Nagaur', 'Nathdwara', 'Pali', 'Phalodi', 'Pushkar', 'Sawai Madhopur', 'Shahpura', 'Sikar', 'Sirohi', 'Tonk', 'Udaipur'],
    'Sikkim': ['Gangtok', 'Gyalshing', 'Lachung', 'Mangan'],
    'Tamil Nadu': ['Arcot', 'Chengalpattu', 'Chennai', 'Chidambaram', 'Coimbatore', 'Cuddalore', 'Dharmapuri', 'Dindigul', 'Erode', 'Kanchipuram', 'Kanniyakumari', 'Kodaikanal', 'Kumbakonam', 'Madurai', 'Mamallapuram', 'Nagappattinam', 'Nagercoil', 'Palayamkottai', 'Pudukkottai', 'Rajapalayam', 'Ramanathapuram', 'Salem', 'Thanjavur', 'Tiruchchirappalli', 'Tirunelveli', 'Tiruppur', 'Thoothukudi', 'Udhagamandalam', 'Vellore'],
    'Telangana': ['Hyderabad', 'Karimnagar', 'Khammam', 'Mahbubnagar', 'Nizamabad', 'Sangareddi', 'Warangal'],
    'Tripura': ['Agartala'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Amroha', 'Ayodhya', 'Azamgarh', 'Bahraich', 'Ballia', 'Banda', 'Bara Banki', 'Bareilly', 'Basti', 'Bijnor', 'Bithur', 'Budaun', 'Bulandshahr', 'Deoria', 'Etah', 'Etawah', 'Faizabad', 'Farrukhabad-cum-Fatehgarh', 'Fatehpur', 'Fatehpur Sikri', 'Ghaziabad', 'Ghazipur', 'Gonda', 'Gorakhpur', 'Hamirpur', 'Hardoi', 'Hathras', 'Jalaun', 'Jaunpur', 'Jhansi', 'Kannauj', 'Kanpur', 'Lakhimpur', 'Lalitpur', 'Lucknow', 'Mainpuri', 'Mathura', 'Meerut', 'Mirzapur-Vindhyachal', 'Moradabad', 'Muzaffarnagar', 'Partapgarh', 'Pilibhit', 'Prayagraj', 'Rae Bareli', 'Rampur', 'Saharanpur', 'Sambhal', 'Shahjahanpur', 'Sitapur', 'Sultanpur', 'Tehri', 'Varanasi'],
    'Uttarakhand': ['Almora', 'Dehra Dun', 'Haridwar', 'Mussoorie', 'Nainital', 'Pithoragarh'],
    'West Bengal': ['Alipore', 'Alipur Duar', 'Asansol', 'Baharampur', 'Bally', 'Balurghat', 'Bankura', 'Baranagar', 'Barasat', 'Barrackpore', 'Basirhat', 'Bhatpara', 'Bishnupur', 'Budge Budge', 'Burdwan', 'Chandernagore', 'Darjeeling', 'Diamond Harbour', 'Dum Dum', 'Durgapur', 'Halisahar', 'Haora', 'Hugli', 'Ingraj Bazar', 'Jalpaiguri', 'Kalimpong', 'Kamarhati', 'Kanchrapara', 'Kharagpur', 'Cooch Behar', 'Kolkata', 'Krishnanagar', 'Malda', 'Midnapore', 'Murshidabad', 'Nabadwip', 'Palashi', 'Panihati', 'Purulia', 'Raiganj', 'Santipur', 'Shantiniketan', 'Shrirampur', 'Siliguri', 'Siuri', 'Tamluk', 'Titagarh'],
  };

  // A map of cities to their respective areas
  static final Map<String, List<String>> cityAreas = {
  // ================= Andhra Pradesh =================
  'Visakhapatnam': ['MVP Colony', 'Gajuwaka', 'Dwaraka Nagar', 'Madhurawada'],
  'Vijayawada': ['Benz Circle', 'Governorpet', 'Auto Nagar'],
  'Guntur': ['Arundelpet', 'Kothapet', 'Brundavan Gardens'],
  'Nellore': ['Balaji Nagar', 'Stonehousepet', 'Muthukur Road'],
  'Kurnool': ['Adoni Road', 'Ashok Nagar', 'Nandyal Road'],

  // ================= Arunachal Pradesh =================
  'Itanagar': ['Naharlagun', 'Bank Tinali', 'Zero Point'],
  'Tawang': ['Old Market', 'Civil Lines', 'Monastery Area'],
  'Ziro': ['Hapoli', 'Old Ziro', 'Market Area'],

  // ================= Assam =================
  'Guwahati': ['Dispur', 'Paltan Bazaar', 'Beltola', 'Fancy Bazaar'],
  'Dibrugarh': ['Mancotta Road', 'Chowkidinghee', 'Graham Bazar'],
  'Silchar': ['Central Road', 'Ambicapatty', 'Tarapur'],
  'Tezpur': ['Mission Chariali', 'Civil Lines', 'Market Area'],

  // ================= Bihar =================
  'Patna': ['Kankarbagh', 'Rajendra Nagar', 'Gandhi Maidan', 'Patliputra Colony'],
  'Gaya': ['Civil Lines', 'Rampur', 'Bodh Gaya Road'],
  'Bhagalpur': ['Tilka Manjhi', 'Sabour', 'Barari'],
  'Muzaffarpur': ['Club Road', 'Brahmapura', 'Motijheel'],
  'Buxar': ['Station Road', 'Civil Lines', 'Main Market'],

  // ================= Chhattisgarh =================
  'Raipur': ['Pandri', 'Shankar Nagar', 'Telibandha'],
  'Bhilai': ['Sector 6', 'Sector 10', 'Civic Centre'],
  'Bilaspur': ['Link Road', 'Civil Lines', 'Telipara'],
  'Korba': ['Transport Nagar', 'Main Market', 'Balco Colony'],

  // ================= Delhi (NCT) =================
  'Delhi': ['Connaught Place', 'Karol Bagh', 'Dwarka', 'Saket', 'Rohini'],

  'Panaji': ['Altinho', 'Campal', 'Fontainhas'],
  'Madgaon': ['Fatorda', 'Colva Road', 'Borda'],

  // ================= Gujarat =================
  'Ahmedabad': ['Maninagar', 'Navrangpura', 'Bopal', 'Satellite', 'Ellis Bridge'],
  'Surat': ['Adajan', 'Katargam', 'Varachha', 'Athwa Lines'],
  'Vadodara': ['Alkapuri', 'Fatehgunj', 'Manjalpur'],
  'Rajkot': ['Kalawad Road', 'Sadar Bazaar', 'University Road'],
  'Bhavnagar': ['Waghawadi Road', 'Ghoghagate', 'Takhteshwar'],

  // ================= Haryana =================
  'Gurugram': ['DLF Phase 1', 'Sohna Road', 'MG Road', 'Palam Vihar'],
  'Faridabad': ['NIT', 'Sector 15', 'Ballabgarh'],
  'Panipat': ['Model Town', 'Sector 13', 'GT Road'],
  'Rohtak': ['Civil Lines', 'Model Town', 'Main Bazaar'],

  // ================= Himachal Pradesh =================
  'Shimla': ['Mall Road', 'Summer Hill', 'Lakkar Bazaar'],
  'Dharamshala': ['McLeod Ganj', 'Kotwali Bazaar', 'Civil Lines'],
  'Mandi': ['Vikashnagar', 'Samkhetar', 'Purani Mandi'],

  // ================= Jammu & Kashmir =================
  'Srinagar': ['Lal Chowk', 'Rajbagh', 'Hazratbal'],
  'Jammu': ['Gandhi Nagar', 'Trikuta Nagar', 'Residency Road'],
  'Anantnag': ['KP Road', 'Lal Chowk', 'Mattan Road'],

  // ================= Jharkhand =================
  'Ranchi': ['Harmu', 'Doranda', 'Kanke Road', 'Lalpur'],
  'Jamshedpur': ['Bistupur', 'Sakchi', 'Sonari'],
  'Dhanbad': ['Saraidhela', 'Bank More', 'Hirapur'],

  // ================= Karnataka =================
  'Bengaluru': ['Whitefield', 'Koramangala', 'Indiranagar', 'Malleshwaram', 'Electronic City'],
  'Mysuru': ['Lakshmipuram', 'Vijayanagar', 'Saraswathipuram'],
  'Hubballi-Dharwad': ['Gokul Road', 'Keshwapur', 'Navanagar'],
  'Mangaluru': ['Hampankatta', 'Kadri', 'Bejai'],

  // ================= Kerala =================
  'Thiruvananthapuram': ['Kazhakoottam', 'Pattom', 'Vellayambalam'],
  'Kochi': ['Marine Drive', 'Edappally', 'Fort Kochi'],
  'Kozhikode': ['Mananchira', 'Kallayi', 'Mavoor Road'],

  // ================= Madhya Pradesh =================
  'Bhopal': ['Arera Colony', 'MP Nagar', 'Kolar Road'],
  'Indore': ['Vijay Nagar', 'Palasia', 'Rajwada'],
  'Gwalior': ['Morar', 'Thatipur', 'Lashkar'],
  'Jabalpur': ['Napier Town', 'Wright Town', 'Civil Lines'],
  'Ujjain': ['Freeganj', 'Mahakal Area', 'Indira Nagar'],

  // ================= Maharashtra =================
  'Mumbai': ['Andheri', 'South Mumbai', 'Dadar', 'Borivali', 'Colaba'],
  'Santacruz':['Vakola','Shastri Nagar','Juhu Koliwada','Prabhat Colony','Golibar'],
  'Khar Road':['Pali Hill','Ambedkar Colony','Khar Danda','Golibar'],
  "Bandra":['Pali Hill','Carter Road','Linking Road','Kherwadi','BKC'],
  'Pune': ['Shivajinagar', 'Kothrud', 'Kalyani Nagar', 'Hinjewadi'],
  'Nagpur': ['Sitabuldi', 'Dharampeth', 'Sadar'],
  'Nashik': ['Panchavati', 'College Road', 'Indira Nagar'],
  'Aurangabad': ['CIDCO', 'Kranti Chowk', 'Shahganj'],
  'Thane' :['Mumbra','kalwa','diwa','bhiwandi'],

  // ================= Manipur =================
  'Imphal': ['Thangal Bazar', 'Singjamei', 'Porompat'],

  // ================= Meghalaya =================
  'Shillong': ['Police Bazaar', 'Laitumkhrah', 'Polo'],
  'Cherrapunji': ['Mawsmai', 'Nongthymmai', 'Main Town'],

  // ================= Mizoram =================
  'Aizawl': ['Dawrpui', 'Chaltlang', 'Zarkawt'],
  'Lunglei': ['Ramthar', 'Zohnuai', 'Electric Veng'],

  // ================= Nagaland =================
  'Kohima': ['PR Hill', 'High School Area', 'Main Town'],
  'Dimapur': ['Duncan Basti', 'Purana Bazaar', 'Zion Colony'],

  // ================= Odisha =================
  'Bhubaneswar': ['Saheed Nagar', 'Kharabela Nagar', 'Jayadev Vihar'],
  'Cuttack': ['Badambadi', 'College Square', 'Choudhury Bazaar'],
  'Puri': ['Swargadwar', 'Chakratirtha Road', 'Baliapanda'],
  'Sambalpur': ['Bareipali', 'Hirakud', 'Budharaja'],

  // ================= Punjab =================
  'Amritsar': ['Ranjit Avenue', 'Hall Bazar', 'Lawrence Road'],
  'Ludhiana': ['Model Town', 'Civil Lines', 'Ferozepur Road'],
  'Jalandhar': ['Adarsh Nagar', 'Model Town', 'BMC Chowk'],
  'Patiala': ['Leela Bhawan', 'Tripuri', 'Model Town'],

  // ================= Rajasthan =================
  'Jaipur': ['Malviya Nagar', 'Vaishali Nagar', 'C-Scheme'],
  'Udaipur': ['Fatehpura', 'Hiran Magri', 'Surajpole'],
  'Jodhpur': ['Ratanada', 'Sojati Gate', 'Paota'],
  'Ajmer': ['Kaisarganj', 'Civil Lines', 'Adarsh Nagar'],

  // ================= Sikkim =================
  'Gangtok': ['MG Marg', 'Deorali', 'Tadong'],
  'Namchi': ['Central Park', 'Upper Namchi', 'Market Area'],

  // ================= Tamil Nadu =================
  'Chennai': ['T. Nagar', 'Anna Nagar', 'Velachery', 'Mylapore'],
  'Coimbatore': ['RS Puram', 'Gandhipuram', 'Saibaba Colony'],
  'Madurai': ['Anna Nagar', 'Tallakulam', 'KK Nagar'],
  'Tiruchirappalli': ['Srirangam', 'Thillai Nagar', 'Cantonment'],
  'Salem': ['Shevapet', 'Fairlands', 'Gugai'],

  // ================= Telangana =================
  'Hyderabad': ['Banjara Hills', 'Jubilee Hills', 'Madhapur', 'Charminar'],
  'Warangal': ['Hanamkonda', 'Kazipet', 'Subedari'],
  'Nizamabad': ['Arsapally', 'Indira Nagar', 'Vinayak Nagar'],

  // ================= Tripura =================
  'Agartala': ['Krishna Nagar', 'Dhaleswar', 'Battala'],

  // ================= Uttar Pradesh =================
  'Lucknow': ['Hazratganj', 'Alambagh', 'Gomti Nagar'],
  'Kanpur': ['Arya Nagar', 'Swaroop Nagar', 'Kidwai Nagar'],
  'Agra': ['Tajganj', 'Sadar Bazar', 'Civil Lines'],
  'Varanasi': ['Assi Ghat', 'Lanka', 'Godowlia'],
  'Prayagraj': ['Civil Lines', 'Daraganj', 'Naini'],

  // ================= Uttarakhand =================
  'Dehradun': ['Rajpur Road', 'Race Course', 'Clock Tower'],
  'Haridwar': ['Kankhal', 'BHEL Township', 'Har Ki Pauri'],
  'Nainital': ['Mallital', 'Tallital', 'Bara Bazaar'],

  // ================= West Bengal =================
  'Kolkata': ['Park Street', 'Salt Lake', 'Garia', 'Howrah'],
  'Siliguri': ['Sevoke Road', 'Pradhan Nagar', 'Hakim Para'],
  'Durgapur': ['Benachity', 'City Centre', 'Muchipara'],
  'Asansol': ['Hutton Road', 'Burnpur', 'Kalyanpur'],
};

  /// Returns a list of all states.
  static List<String> get states => stateCities.keys.toList();

  /// Returns a list of cities for a given [state].
  static List<String> getCities(String state) {
    return stateCities[state] ?? [];
  }

  /// Returns a list of areas for a given [city].
  static List<String> getAreas(String city) {
    return cityAreas[city] ?? [];
  }

}